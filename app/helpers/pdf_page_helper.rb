module PdfPageHelper
	require 'date'
	class SendLetter < Prawn::Document 
		def initialize(pdf,item_array, place_array,records_array, page_list, pick)
			
		# if(params["create_pages"] != nil)
		# 	# @contracts.each do |pick_id|
		#           puts params["create_pages"] + " : page "
		#        # end
		# end
	
		# page_letter_1(pdf,item_array,place_array,records_array)
		
			# page_list.each do |z|
			# 	puts z.to_s + " : each page"
			# 	z = z.to_i
			zvar = pick.to_i
				case zvar
					when 1
						puts "print pdf page " + zvar.to_s + " : parts : " + item_array.length.to_s
					  	page_letter_1(pdf,item_array,place_array,records_array)
					when 2
					  	page_letter_2(pdf,item_array,place_array,records_array)
					when 3
						# 	puts "print pdf page " + zvar.to_s + " : parts : " + item_array.length.to_s
						# 	puts place_array[0][1].to_s + " : " 
						page_letter_3(pdf, item_array, place_array, records_array)
					when 4
					 #  	puts "print pdf page " + zvar.to_s + " : parts : " + item_array.length.to_s
						# puts place_array[0][1].to_s + " : " 
					  	page_letter_4(pdf, item_array, place_array, records_array)
					when 5
					 	page_letter_5(pdf, item_array, place_array, records_array)
					when 6
						page_letter_6(pdf, item_array, place_array, records_array)
					when 7
						page_letter_7(pdf, item_array, place_array, records_array)
					when 8
						page_letter_8(pdf, item_array, place_array, records_array)
					when 9
						page_letter_9(pdf, item_array, place_array, records_array)
					when 13..100
					  	puts "no pdf print page selection"  	
					  	# page_letter_2(pdf,item_array,place_array,records_array)
					when 10
						puts "print pdf page " + zvar.to_s + " : parts : " + item_array.length.to_s
						puts place_array[0][1].to_s + " : " 
					  	page_letter_3(pdf, item_array, place_array, records_array)
					when 12
						page_letter_4(pdf, item_array, place_array, records_array)
					  	puts "no pdf print page selection"

					else
						puts "Error: no pdf print page or record"
				end
			# end 
		end


	












# Assignment of $
		def page_letter_1(pdf,item_array,place_array,records_array)
			# stroke_color "f0ffc1"
			# side logo displaied as backdrop
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
	            # pdf.rectangle [120, 100], 4, 700
	            # pdf.rectangle [120, 100],120,100
	            pdf.fill_color "000000"
	            # pdf.fill_rectangle [200, 10],0, 0
				# pdf.fill { rectangle [200, 100], 100, 100 }
				pdf.transparent(1.0, 0.2) do 
					#pdf.image open("app/assets/images/point_logo.png"), :fit => [500, 500], :at => [180, -100]#, 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
               # pdf.font("app/assets/font/Spirax-Regular.ttf")
	           pdf.fill_color "000000"
	           # pdf.font "Arial", size: 11
	           # pdf.image open("app/assets/images/point_logo.png"), :fit => [130, 135]
	           # pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000]
			   # , :color => "00ff00"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
				pdf.rectangle [110, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_color "ff0000"
				pdf.rectangle [310, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end

	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end


			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')



			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new
			groupName = groupName.localtime.strftime('%b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )

			full_name = records_array.client_first_name + " " + records_array.client_last_name

			head_name = full_name
			full_name_show = head_name.gsub('#{full_name}', head_name )

			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			intro = item_array[4]
			intro = intro.gsub('#{full_name}', full_name )
			intro = intro.gsub('#{nick_name}', full_name )

			para_A = item_array[5].to_s 
			para_A = para_A.sub('#{full_name}', full_name )
			para_A = para_A.sub('#{agent_code}', full_name )
			# wash para B
			para_B = item_array[6].to_s
			# find vars and replace 
			para_B = para_B.sub('#{loan_rate}', records_array.stated_rate.to_s )
			para_B = para_B.sub('#{total_loan}', number_to_currency(records_array.total_amount) )
			st_date = records_array.repay_start.strftime("%B")
			para_B = para_B.sub('#{start_month}', st_date )	
			sign_to = item_array[9].to_s 
			sign_to = sign_to.sub('#{full_name}', full_name )
			

			tag_height = 14
			# step = up_one(step) 


			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				# move_l = place_array[step][0].to_f
				# move_r = 750.00
				var_x = place_array[step][0]
				var_y = place_array[step][1]
				# adjust_x = var_x + -50
				# adjust_y = var_y + 300
				# var_x = 20.0
				# var_y = 10.0
				# var_y = var_y
				# pdf.bounding_box([ adjust_x, adjust_y],{ :width => 300, :height => 20}) do
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					# pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					# pdf.text 
					# pdf.text place_array[step][1].to_s
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			# play = 1
			# play = place_array[step][0].to_i + 10
			# play = play.to_s

			# @parts.page_area 



    		# page layout 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				pdf.font "OpenSans", size: 10 
				# var_x = place_array[step][0]
				# var_y = place_array[step][1]	
				# pdf.bounding_box([ place_array[step][0], place_array[step][1] ] ), { :width => 200, :height => 300}) do
				# pdf.font "/app/assets/fonts/Spirax-Regular.ttf"
				# pdf.text item_array[step], {:color => "00ff00"}
				pdf.text say_date #, {:color => "00ff00"}
				# pdf.text place_array[step][0].to_s
				# pdf.text place_array[step][1].to_s

				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			
			# skip client info
			# step = up_one(step)  
			# pdf.bounding_box( [ place_array[step][0], place_array[step][1] ] ),{ :width => 200, :height => 30}) do
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# get_page_loc(step, place_array, pdf);
				# pdf.text records_array.loan_name	
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Client info 2
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
				pdf.text records_array.loan_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, var_x, var_y);
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )

			end
			step = up_one(step)  

			# info 3
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text full_name_show , {:color => "000000"}
				pdf.text records_array.client_first_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end

			step = up_one(step)			
			# #Address 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				# pdf.font "OpenSans", size: 10 
				pdf.text comp_address + " \n" + comp_address_state
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end

			step = up_one(step)
			# #intro 5
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 16) do
				pdf.text intro
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			#para 01 6
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				# pdf.text item_array[step]
				# pdf.text item_array[5]
				pdf.text para_A 
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			# text item_array[step]
			# end
			step = up_one(step)
			#para 02 7
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				
				pdf.text para_B
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			
			end
			step = up_one(step) 
			#para 03 8
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #ender 9
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #sign to 10
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	# pdf.text item_array[step]
				pdf.text sign_to
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			#sign from 11
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
		end

# Assignment of %


		def page_letter_2(pdf,item_array,place_array,records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
	            pdf.fill_color "ff0000"
				pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
            pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
				pdf.rectangle [110, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_color "ff0000"
				pdf.rectangle [310, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end
			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new
			groupName = groupName.localtime.strftime('%b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )
			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name
			full_name_show = head_name.gsub('#{full_name}', head_name )
			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;



			intro = item_array[4]
			intro = intro.gsub('#{first_name}', full_name )

			para_A = item_array[5].to_s 
			para_A = para_A.sub('#{full_name}', full_name )
			para_A = para_A.sub('#{agent_code}', records_array.agent_num.to_s )
			# para_A = para_A.sub('#{agent_code}', records_array.agent_num.to_s )
			# wash para B
			para_B = item_array[6].to_s
			# find vars and replace 
			para_B = para_B.sub('#{start_month}', records_array.repay_start.to_s )
			para_B = para_B.sub('#{total_amount}', number_to_currency(records_array.total_amount) )
			para_B = para_B.sub('#{percent_of}', "--unkown--" )
			# st_date = records_array.repay_start.strftime("%B")
			# para_B = para_B.sub('#{start_month}', st_date )	
			sign_to = item_array[9].to_s 
			sign_to = sign_to.sub('#{full_name}', full_name )

			tag_height = 14
			# step = up_one(step) 
			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				var_x = place_array[step][0]
				var_y = place_array[step][1]
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			
    		# page layout 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# var_x = place_array[step][0]
				# var_y = place_array[step][1]	
				# pdf.bounding_box([ place_array[step][0], place_array[step][1] ] ), { :width => 200, :height => 300}) do
				# pdf.font "/app/assets/fonts/Spirax-Regular.ttf"
				# pdf.text item_array[step], {:color => "00ff00"}
				pdf.font "OpenSans", size: 10
				pdf.text say_date, {:color => "000000"}
				# pdf.text place_array[step][0].to_s
				# pdf.text place_array[step][1].to_s

				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			
			# skip client info
			# step = up_one(step)  
			# pdf.bounding_box( [ place_array[step][0], place_array[step][1] ] ),{ :width => 200, :height => 30}) do
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# get_page_loc(step, place_array, pdf);
				# pdf.text records_array.loan_name	
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Client info 2
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
				pdf.text records_array.loan_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, var_x, var_y);
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )

			end
			step = up_one(step)  

			# info 3
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text full_name_show , {:color => "000000"}
				pdf.text records_array.client_first_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end

			step = up_one(step)			
			# #Address 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
	
				pdf.text comp_address + " \n" + comp_address_state
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end

			step = up_one(step)
			# # #intro 5
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 16) do
				pdf.text intro
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #para 01 6
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text para_A
			# 	# pdf.text item_array[5]
			# 	pdf.text para_A 
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			# # text item_array[step]
			# # end
			step = up_one(step)
			# #para 02 7
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				# pdf.text item_array[step]
				pdf.text para_B
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			
			end
			step = up_one(step) 
			# #para 03 8
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #ender 9
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #sign to 10
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				# pdf.text item_array[step]
				pdf.text sign_to
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #sign from 11
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
		end






		def page_letter_3(pdf, item_array, place_array, records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [100, 440]) do
	            pdf.fill_color "ff0000"
	          	pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/point_logo.png"), :fit => [80, 80], :at => [10, 110]
				end
				# pdf.image open("app/assets/images/point_logo.png")
	        	pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 0],{ :width => 200, :height => 100 }) do
				# pdf.rectangle [240, 350], 310, 2
				# pdf.fill_rectangle [10, 510],0, 0
				# pdf.fill_color "ff0000"
				# pdf.rectangle [310, 190], 180, 2
				# pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end


			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new

			groupName = groupName.localtime.strftime('  %b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )





			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name

			full_name_show = head_name.gsub('#{full_name}', records_array.client_first_name )
			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			intro = item_array[9].to_s

			intro = intro.sub('#{first_name}', head_name )
			# agent = item_array[4].to_s
			# agent = agent.gsub('#{A----}', records_array.agent_num )
			# agent = agent.gsub('#{agent_name}', full_name )

			intro = item_array[4].to_s 
			intro = intro.sub('#{first_name}', records_array.client_first_name )


			closing = item_array[9].to_s
			closing = closing.sub('#{first_name}', records_array.client_first_name )
			

			para_A = item_array[6].to_s 
			para_A = para_A.sub('#{start_date}', records_array.repay_start.strftime('%B, %Y').to_s )
			para_A = para_A.sub('#{current_date}', records_array.current_date.strftime('%B %d, %Y').to_s )
			para_A = para_A.sub('#{total_amount}', number_to_currency(records_array.total_amount ) )
			para_A = para_A.sub('#{final_date}', records_array.final_date.strftime('%B, %Y').to_s )

			# wash para B
			para_B = item_array[7].to_s

			fin = number_to_currency(records_array.fin_fee)

			# .to_f, precision: 2
			
			para_B = para_B.sub('#{commencement_m}', records_array.commencement_m.to_s )
			para_B = para_B.sub('#{commencement_y}', records_array.commencement_y.to_s )
			para_B = para_B.sub('#{fin_fee}', fin.to_s )
			para_B = para_B.sub('#{repay_term1}', records_array.repay_term1.to_s )
			
			# find vars and replace 
			# para_B = para_B.sub('#{loan_rate}', records_array.stated_rate.to_s )
			# para_B = para_B.sub('#{total_loan}', number_to_currency(records_array.total_amount) )
			# st_date = records_array.repay_start.strftime("%B")
			# para_B = para_B.sub('#{start_month}', st_date )	
			# sign_to = item_array[9].to_s 
			agent_num = records_array.agent_num.to_s


			sign_from = item_array[8].to_s
			sign_from = sign_from.sub('#{agent_num}', agent_num )
			sign_from = sign_from.sub('#{full_name}', full_name )
			tag_height = 14
			# step = up_one(step) 
			step = 0


			start_date = item_array[13].to_s
			start_date = start_date.sub('#{start_date}', records_array.repay_start.strftime('%b %d, %Y').to_s )


			# start_date = item_array[14].to_s 
			# start_date = start_date.sub('#{start_date}', records_array.repay_start.strftime('%B, %Y').to_s )



			total_amount = number_to_currency(records_array.total_amount ) 
			promise = item_array[16].to_s
			promise = promise.sub('#{full_name}', full_name )
			promise = promise.sub('#{total_loan}', total_amount )


			sect_02 = item_array[18] 
			sect_02 = sect_02.sub('#{repay_monthly}', number_to_currency(records_array.total_default.to_s ))
			
			sect_02 = sect_02.sub('#{repay_term1}', records_array.repay_term1 )

			sect_02 = sect_02.sub('#{start_date}', records_array.note_date.strftime('%b %d, %Y').to_s )

			sect_02 = sect_02.sub('#{repay_penalty}', number_to_currency(records_array.repay_penalty ) )
			sect_02 = sect_02.sub('#{repay_start}',	records_array.repay_start.strftime('%b %d, %Y').to_s  )
			sect_02 = sect_02.sub('#{stated_rate}', records_array.stated_rate.to_s  )
			sect_02 = sect_02.sub('#{loan_act_fee}', records_array.loan_act_fee.to_s )


			sect_03 = item_array[20] 

			sect_03 = sect_03.sub('#{repay_monthly}', number_to_currency(records_array.total_default.to_s ))
			
			sect_03 = sect_03.sub('#{repay_term1}', records_array.repay_term1 )
			# sect_03 = sect_03.sub('#{repay_term2}', records_array.repay_term2 )

			# sect_03 = sect_03.sub('#{repay_start}', records_array.repay_start.strftime('%b %d, %Y').to_s )
			sect_03 = sect_03.sub('#{payment_mth_day}', records_array.payment_mth_day.to_s  )

			# sect_03 = sect_03.sub('#{repay_mature}', records_array.repay_mature.to_s  )
			# sect_03 = sect_03.sub('#{loan_act_fee}', number_to_currency(records_array.loan_act_fee ) )

			# sect_03 = sect_03.sub('#{repay_penalty}', number_to_currency(records_array.repay_penalty ) )
			# sect_03 = sect_03.sub('#{repay_start}',	records_array.repay_start.strftime('%b %d, %Y').to_s  )

			sect_03 = sect_03.sub('#{loan_act_fee}',  number_to_currency(records_array.loan_act_fee.to_s ))

			percent = records_array.stated_rate.to_i * 0.01 
			percent_of = records_array.loan_amount.to_i * percent 

			sect_03 = sect_03.sub('#{total_default}', number_to_currency(percent_of.to_s))

			# monthly_pay = (percent_of + records_array.total_default.to_i) / records_array.repay_term1.to_i

			# sect_03 = sect_03.sub('#{total_default}', number_to_currency( monthly_pay ) )








			def get_page_loc(step, place_array, pdf, var_x, var_y)
				# move_l = place_array[step][0].to_f
				# move_r = 750.00
				var_x = place_array[step][0]
				var_y = place_array[step][1]
			
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					# pdf.text 
					# pdf.text place_array[step][1].to_s
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			# page layout area  : Area 1
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 530, :height => 16}) do
				pdf.font "OpenSans", size: 11
				pdf.text say_date 
				#, {:color => "00ff00"}
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			step = up_one(step)
			#  # name : Area 2
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 530, :height => 40}) do
				pdf.text item_array[step]
			#  	pdf.text full_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			# # 	# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# # Full name
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 530, :height => 16) do
				pdf.text full_name_show
			# # 	get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)  

			# # address : Area 3
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 530, :height => 30) do
			# 	# pdf.font "OpenSans", size: 10 
				pdf.text comp_address + " \n" + comp_address_state
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)			

			# # reply : Area 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
			# 	# pdf.font "OpenSans", size: 10 
				pdf.text intro 
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # # agent : para 01
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # para LIST
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 530, :height => 60) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # # text item_array[step]
			# # # end
			
			# #para 2
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 530, :height => 80) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step) 
			# #para CLOSE ADDRESS
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 80) do
				pdf.text item_array[step]
			# 	pdf.text para_B
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # closing 
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 40) do
				pdf.text closing
			# 	pdf.text sign_from
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # # footer
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
				pdf.text item_array[step]
			# 	pdf.text item_array[step].to_s
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			#sign to
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
				pdf.text item_array[step].to_s
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end


			pdf.start_new_page
##########################################################################################
			step = up_one(step)
			#  title

			# pdf.bounding_box([ 210, 710],{ :width => 530, :height => 40}) do
				pdf.text " PROMISSORY NOTE ", style: :bold, :align => :center
			 	# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			# end

			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 530, :height => 40}) do
				pdf.text total_amount
			 	# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)
			
			#sign to
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
				pdf.text start_date
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)

			#location 
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
				pdf.text item_array[step].to_s
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)

			#section 
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
				pdf.text item_array[step].to_s
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)

			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 110) do
				pdf.text promise, :inline_format => true
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)

		    pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 500, :height => 110) do
				pdf.text item_array[step].to_s, :inline_format => true
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)

		    pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 460, :height => 140) do
				pdf.font "OpenSans", size: 10 
				pdf.text sect_02, :inline_format => true
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 560, :height => 30) do
				pdf.font "OpenSans", size: 11
				pdf.text item_array[step].to_s
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			

			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 200) do
				pdf.text sect_03, :inline_format => true
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end 
			step = up_one(step)

			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 30) do
			# 	pdf.text item_array[step].to_s, :inline_format => true
			# # 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)


			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 60) do
			# 	pdf.text item_array[step].to_s, :inline_format => true
			# # 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)

			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 100) do
			# 	pdf.text sect_03.to_s, :inline_format => true
			# # 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)


			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 530, :height => 100) do
			# 	pdf.text item_array[step].to_s, :inline_format => true
			# # 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
##########################################################################################
			pdf.start_new_page




		end





		# Contract 4 Loan Confirmation
		def page_letter_4(pdf, item_array, place_array, records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
	            pdf.fill_color "ff0000"
	          	pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
	        	pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 0],{ :width => 200, :height => 100 }) do
				# pdf.rectangle [240, 350], 310, 2
				# pdf.fill_rectangle [10, 510],0, 0
				# pdf.fill_color "ff0000"
				# pdf.rectangle [310, 190], 180, 2
				# pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end

			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new


			groupName = groupName.localtime.strftime('  %b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )

			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;


			law_header = item_array[1].to_s
			# law_header = item_array[2].to_s
			confirm = item_array[2].to_s
			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name			
			agency = item_array[4].to_s
			agency = agency.gsub('#{agent_code}', records_array.agent_num )

			para_A = item_array[6].to_s
			para_A = para_A.sub('#{full_name}', head_name )
			para_A = para_A.sub('#{first_name}', records_array.client_first_name )
			para_A = para_A.sub('#{company}',  records_array.loan_name)
			




			tag_height = 14
			# step = up_one(step) 
			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				# move_l = place_array[step][0].to_f
				# move_r = 750.00
				var_x = place_array[step][0]
				var_y = place_array[step][1]
			
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					# pdf.text 
					# pdf.text place_array[step][1].to_s
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			# page layout area  : Area 1
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				pdf.text say_date, {:color => "000000"}
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			step = up_one(step)
			 # name : Area 2
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 100}) do
				pdf.text law_header , {:color => "000000"}
				# pdf.text full_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Client info 3
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 20) do
				pdf.text confirm 
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)  

			# address : Area 3
			pdf.bounding_box([ place_array[step][0],  place_array[step][1]  ], :width => 430, :height => 24) do
				# pdf.font "OpenSans", size: 10 
				pdf.text head_name
				# pdf.text comp_address + " \n" + comp_address_state
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)			

			# reply : Area 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				# pdf.font "OpenSans", size: 10 
				pdf.text agency
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # agent : Area 5 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[5].to_s
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# intro : Area 6
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 60) do
				# pdf.text intro 
				pdf.text para_A
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # text item_array[step]
			# # end
			
			#para 01 Area 7
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 80) do
				# pdf.text para_A
				pdf.text item_array[7].to_s
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step) 
			#para 02 : Area 8
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 80) do
				# pdf.text para_B
				pdf.text item_array[8].to_s
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #sign_to : Area 9
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 60) do
				# pdf.text agency
				pdf.text item_array[9].to_s
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			# step = up_one(step)
			# # # #sign to 10
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# # # 	# pdf.text item_array[step]
			# pdf.text item_array[step].to_s
				# pdf.text item_array[10].to_s
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# # #sign from 11
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step].to_s
				# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
		end



		# commission form
		def page_letter_5(pdf, item_array, place_array, records_array)
				pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
		            pdf.fill_color "ff0000"
		          	pdf.transparent(1.0, 0.2) do 
						pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
					end
		        	pdf.fill_color "000000"
		        end
		        # page sign lines
		        pdf.bounding_box([0, 0],{ :width => 200, :height => 100 }) do
		        	
		        	# pdf.rectangle [ 150, 690 ], 310, 2
		        	# pdf.rectangle [ 150, 670 ], 310, 2
		        	# pdf.rectangle [ 150, 650 ], 310, 2
		        	# pdf.fill_color "000000"
		        	pdf.stroke_color '000000'
		        	pdf.rectangle [190, 690], 110, 1
		        	pdf.rectangle [350, 690], 190, 1
				# address 
					pdf.rectangle [190, 670], 350, 1
		        	pdf.rectangle [250, 650], 290, 1

					pdf.rectangle [250, 630], 290, 1
				# phone email 	        	# 
		        	pdf.rectangle [190, 610], 60, 1
		        	pdf.rectangle [280, 610], 210, 1
				# lender info 
		        	pdf.rectangle [220, 570], 320, 1
		        	pdf.rectangle [220, 550], 320, 1
		        	pdf.rectangle [160, 530], 380, 1
		        	pdf.rectangle [160, 510], 380, 1

		        	pdf.rectangle [140, 490], 80, 1
		        	pdf.rectangle [250, 490], 280, 1
				# para 01
		        	pdf.rectangle [160, 440], 360, 3
				# form 2 agent sign 
		        	pdf.rectangle [250, 290], 290, 1
		        	pdf.rectangle [250, 270], 290, 1
		        	pdf.rectangle [190, 250], 90, 1


					# form C Lender sign
		        	pdf.rectangle [400, 190], 140, 1
		        	pdf.rectangle [400, 170], 140, 1
		        	pdf.rectangle [190, 150], 90, 1

					pdf.fill_rectangle [10, 510],0, 0

					# pdf.fill_color "ff0000"
					# pdf.rectangle [310, 190], 180, 2
					# pdf.fill_rectangle [10, 100],0, 0
					# pdf.fill_rectangle [240, 510],0, 0
		        end
		        
		        def up_one(step)
		        	step = step + 1
		        	return step	
		        end

			    def number_to_currency(num)
				  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
				end


				PagePart.order('part_area ASC').reorder('id ASC')
				PageLayout.order('part_area ASC').reorder('id ASC')
				
				my_string = item_array[0].to_s
				gettime = Time.new
				date = gettime.localtime.strftime('  %b %d, %Y')


				title = item_array[0].to_s
				# my_string.gsub('#{current_date}', groupName )

				comp_address =  records_array.address_street;
				comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

				form_A_1 = 		item_array[1].to_s

				full_name = records_array.client_first_name.to_s  + " " + records_array.client_last_name.to_s 

				# form_A_1 = form_A_1.gsub('#{full_name}', "Moe" )

				form_A_1 = form_A_1.gsub('#{full_name}', records_array.loan_name.to_s )
				form_A_1 = form_A_1.gsub('#{agent_code}', records_array.agent_num )
				
				
				form_A_2 = 			item_array[2].to_s
					form_A_2 = 		form_A_2.gsub('#{full_name}', full_name )

				form_A_3 = 			item_array[3].to_s
					form_A_3 = 		form_A_3.gsub('#{address_street}', records_array.address_street )

				form_A_4 = 			item_array[4].to_s
					# form_A_4 = 		form_A_4.gsub('#{address_city}', "hello" )
					# form_A_4 = "hello"
					form_A_4 = 		form_A_4.gsub('#{address_city}', records_array.address_city )
					form_A_4 = 		form_A_4.gsub('#{address_state}', records_array.address_state )
					form_A_4 = 		form_A_4.gsub('#{address_zip}', records_array.address_zip )
					

				form_A_5 = 			item_array[5].to_s
					form_A_5 =		form_A_5.gsub('#{agent_phone}', records_array.agent_phone )
					form_A_5 =		form_A_5.gsub('#{agent_email}', records_array.agent_email )

				form_A_6 = 			item_array[6].to_s
				form_A_7 = 			item_array[7].to_s
				form_A_8 = 			item_array[8].to_s
				form_A_9 = 			item_array[9].to_s
				form_A_10 = 		item_array[10].to_s

				para_A = 			item_array[11].to_s
				# form B
				form_B_1 = 			item_array[12].to_s
					form_B_1 =		form_B_1.gsub('#{agent_name}', full_name )

				form_B_2 = 			item_array[13].to_s
		

				form_B_3 = 			item_array[14].to_s
					form_B_3 = 		form_B_3.gsub('#{current_date}', date )

				para_B = 			item_array[15].to_s

				form_C_1 = 			item_array[16].to_s
				form_C_2 = 			item_array[17].to_s

				form_C_3 = 			item_array[18].to_s
				form_C_3 = 			item_array[18].to_s
					form_C_3 = 		form_C_3.gsub('#{current_date}', date )

				tag_height = 14
				# step = up_one(step) 
				step = 0

				def get_page_loc(step, place_array, pdf, var_x, var_y)
					# move_l = place_array[step][0].to_f
					# move_r = 750.00
					var_x = place_array[step][0]
					var_y = place_array[step][1]
				
						
					pdf.indent 320, 0 do
						pdf.stroke_color 'FFFF00'
						pdf.stroke_bounds
						pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
						# pdf.text 
						# pdf.text place_array[step][1].to_s
						pdf.line_to [var_x, var_y]
					end
						# pdf.rectangle [var_x, var_y], 100, 200
					# end
				end
				# page layout area  : Area 1
				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 30}) do
					pdf.font "OpenSans", size: 8 , style: :bold
					pdf.text title, {:color => "000000" , :character_spacing => 0.5}
					pdf.font "OpenSans", size: 8 
					# pdf.font "Arial", size: 10 

					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)
				
				# Form line 1
				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 60}) do
					pdf.text form_A_1, {:color => "000000"  , :character_spacing => 0.5}
					# pdf.rectangle [ 150, 690 ], 310, 2
					# pdf.text form_A_2, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)
				

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_2, {:color => "000000"  , :character_spacing => 0.5}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)
				

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_3, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)
				
				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_4, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_5, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_6, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_7, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_8, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_9, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_A_10, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 400, :height => 100}) do
					pdf.text para_A, {:color => "000000", size: 8, :inline_format => "true" }
					pdf.font "OpenSans", size: 8 
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_B_1, {:color => "000000",  size: 8}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_B_2, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_B_3, {:color => "000000" }
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 30}) do
					pdf.text para_B, {:color => "000000", size: 8, :inline_format => "true"  }
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)

				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_C_1, {:color => "000000" }
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_C_2, {:color => "000000"}
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)


				pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
					pdf.text form_C_3, {:color => "000000", size: 8 }
					# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
		        end
				step = up_one(step)
		end




		def page_letter_6(pdf,item_array,place_array,records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
	            pdf.fill_color "000000"
				pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
	           pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
				pdf.rectangle [110, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_color "ff0000"
				pdf.rectangle [310, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end
			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new
			groupDate = groupName.localtime.strftime('%b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupDate )
			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name
			full_name_show = head_name.gsub('#{full_name}', head_name )
			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			agent_info = item_array[4].to_s
			agent_info = agent_info.gsub('#{full_name}', full_name )
			agent_info = agent_info.gsub('#{agent_code}', records_array.agent_num )

			intro = item_array[5]
			intro = intro.gsub('#{full_name}', full_name )

			para_A = item_array[6].to_s 
			para_A = para_A.sub('#{start_date}', records_array.repay_start.to_s  )
			para_A = para_A.sub('#{final_date}', records_array.repay_mature.to_s  )
			para_A = para_A.sub('#{start_date}', records_array.repay_start.to_s  )
			para_A = para_A.sub('#{current_date}', say_date  )

			reply = item_array[3].to_s
			st_date = records_array.repay_start.strftime("%B")
			# para_B = para_B.sub('#{start_month}', st_date )	
			sign_to = item_array[8].to_s 
			sign_to = sign_to.sub('#{full_name}', full_name )
			sign_to = sign_to.sub('#{agent_code}', records_array.agent_num )

			tag_height = 14
			# step = up_one(step) 
			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				var_x = place_array[step][0]
				var_y = place_array[step][1]
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			
    		# page layout 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				pdf.font "OpenSans", size: 10 
				pdf.text say_date, {:color => "000000"}
				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			
			# skip client info
			# step = up_one(step)  
			# pdf.bounding_box( [ place_array[step][0], place_array[step][1] ] ),{ :width => 200, :height => 30}) do
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# get_page_loc(step, place_array, pdf);
				# pdf.text records_array.loan_name	
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Client info 2
			# pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text records_array.loan_name , {:color => "000000"}
			# 	# get_page_loc(step, place_array, pdf, var_x, var_y);
			# 	get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )

			# end
			# step = up_one(step)  

			# info 3
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text full_name_show , {:color => "000000"}
				pdf.text full_name , {:color => "000000"}
				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end

			step = up_one(step)			
			# #Address 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				
				pdf.text comp_address + " \n" + comp_address_state
				get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end

			step = up_one(step)
			# # #intro 5
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 16) do
				pdf.text reply
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #para 01 6
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text agent_info
			# 	# pdf.text item_array[5]
			# 	pdf.text para_A 
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			# # text item_array[step]
			# # end
			step = up_one(step)
			# #para 02 7
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				# pdf.text item_array[step]
				pdf.text intro
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			
			end

			step = up_one(step)
			# #para 02 7
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				# pdf.text item_array[step]
				pdf.text para_A
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			
			end
			step = up_one(step) 
			# #para 03 8
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #ender 9
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				# pdf.text item_array[step]
				pdf.text sign_to
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #sign to 10
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	pdf.text sign_to
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #sign from 11
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
		end




		def page_letter_7(pdf,item_array,place_array,records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
	            pdf.fill_color "ff0000"
				pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
	            pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
				pdf.rectangle [110, 290], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_color "ff0000"
				pdf.rectangle [310, 290], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end
			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new
			groupName = groupName.localtime.strftime('%b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )
			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name


			full_name_show = head_name.gsub('#{full_name}', head_name )
			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip
			address = item_array[2]
		
			intro = item_array[4]
			intro = intro.gsub('#{first_name}', records_array.client_first_name  )

			para_A = item_array[5].to_s 
			para_A = para_A.sub('#{full_name}', full_name )

			# # wash para B
			para_C = item_array[7].to_s
			para_C = para_C.sub('#{agent_code}', records_array.agent_num.to_s )
	
			sign_to = item_array[8].to_s 
			sign_to = sign_to.sub('#{full_name}', full_name )

			tag_height = 14
			# step = up_one(step) 
			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				var_x = place_array[step][0]
				var_y = place_array[step][1]
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					pdf.line_to [var_x, var_y]
				end
			end
			
    		# page layout date
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				pdf.font "OpenSans", size: 10 	
				pdf.text say_date, {:color => "000000"}
			end
			
			# name
			step = up_one(step)  
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				pdf.text full_name	
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Address 
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 24) do
				# 	pdf.text records_array.loan_name , {:color => "000000"}
				pdf.text comp_address + " \n" + comp_address_state
				end
			step = up_one(step)  

			# Re :
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text full_name_show , {:color => "000000"}
				pdf.text  item_array[step]
			end

			step = up_one(step)			
			# intro 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text intro
			end

			step = up_one(step)
			# para 1
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 16) do
				pdf.text para_A
			end
			step = up_one(step)
			# #para 01 6
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 40) do
				pdf.text item_array[step]
			# 	# pdf.text item_array[5]
			# 	pdf.text para_A 
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			# text item_array[step]
			# # end
			step = up_one(step)
			# #para 02 7
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				pdf.text para_C
			end
			step = up_one(step) 
			# #para 03 8
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text sign_to
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #ender 9
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# # #sign to 10
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.text item_array[step]
			# 	pdf.text sign_to
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #sign from 11
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 200, :height => 60) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
			step = up_one(step)
			# #sign from 11
			pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 200, :height => 60) do
				pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end
		end




		def page_letter_8(pdf,item_array,place_array,records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do

	            pdf.fill_color "ff0000"

				pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
	           pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
				pdf.rectangle [110, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_color "ff0000"
				pdf.rectangle [310, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end
			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new
			groupName = groupName.localtime.strftime('%b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )
			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name
			full_name_show = head_name.gsub('#{full_name}', head_name )
			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			intro = item_array[4]
			intro = intro.gsub('#{full_name}', full_name )

			para_A = item_array[5].to_s 
			para_A = para_A.sub('#{full_name}', full_name )

			# wash para B
			para_B = item_array[6].to_s
			# find vars and replace 
			para_B = para_B.sub('#{loan_rate}', records_array.stated_rate.to_s )
			para_B = para_B.sub('#{total_loan}', number_to_currency(records_array.total_amount) )
			st_date = records_array.repay_start.strftime("%B")
			para_B = para_B.sub('#{start_month}', st_date )	
			sign_to = item_array[9].to_s 
			sign_to = sign_to.sub('#{full_name}', full_name )

			tag_height = 14
			# step = up_one(step) 
			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				var_x = place_array[step][0]
				var_y = place_array[step][1]
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			
    		# page layout 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# var_x = place_array[step][0]
				# var_y = place_array[step][1]	
				# pdf.bounding_box([ place_array[step][0], place_array[step][1] ] ), { :width => 200, :height => 300}) do
				# pdf.font "/app/assets/fonts/Spirax-Regular.ttf"
				# pdf.text item_array[step], {:color => "00ff00"}
				pdf.text say_date, {:color => "00ff00"}
				# pdf.text place_array[step][0].to_s
				# pdf.text place_array[step][1].to_s

				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			
			# skip client info
			# step = up_one(step)  
			# pdf.bounding_box( [ place_array[step][0], place_array[step][1] ] ),{ :width => 200, :height => 30}) do
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# get_page_loc(step, place_array, pdf);
				# pdf.text records_array.loan_name	
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Client info 2
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
				pdf.text records_array.loan_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, var_x, var_y);
				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )

			end
			step = up_one(step)  

			# info 3
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text full_name_show , {:color => "000000"}
				pdf.text records_array.client_first_name , {:color => "000000"}
				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end

			step = up_one(step)			
			# #Address 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.font "OpenSans", size: 10 
				pdf.text comp_address + " \n" + comp_address_state
				get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end

			# step = up_one(step)
			# # #intro 5
			# pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 16) do
			# 	pdf.text intro
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# #para 01 6
			# pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	# pdf.text item_array[step]
			# 	# pdf.text item_array[5]
			# 	pdf.text para_A 
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# # text item_array[step]
			# # end
			# step = up_one(step)
			# #para 02 7
			# pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				
			# 	pdf.text para_B
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			
			# end
			# step = up_one(step) 
			# #para 03 8
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# # #ender 9
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# # #sign to 10
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# # 	# pdf.text item_array[step]
			# 	pdf.text sign_to
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# #sign from 11
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
		end




		def page_letter_9(pdf,item_array,place_array,records_array)
			pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do

	            pdf.fill_color "ff0000"

				pdf.transparent(1.0, 0.2) do 
					pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
				end
	           pdf.fill_color "000000"
	        end
	        # page sign lines
	        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
				pdf.rectangle [110, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_color "ff0000"
				pdf.rectangle [310, 190], 180, 2
				pdf.fill_rectangle [10, 100],0, 0
				# pdf.fill_rectangle [240, 510],0, 0
	        end
	        
	        def up_one(step)
	        	step = step + 1
	        	return step	
	        end

		    def number_to_currency(num)
			  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			end
			PagePart.order('part_area ASC').reorder('id ASC')
			PageLayout.order('part_area ASC').reorder('id ASC')
			current_date = records_array.client_first_name.to_s
			my_string = item_array[0].to_s
			groupName = Time.new
			groupName = groupName.localtime.strftime('%b %d, %Y')
			say_date = my_string.gsub('#{current_date}', groupName )
			full_name = records_array.client_first_name + " " + records_array.client_last_name
			head_name = full_name
			full_name_show = head_name.gsub('#{full_name}', head_name )
			comp_address =  records_array.address_street;
			comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			intro = item_array[4]
			intro = intro.gsub('#{full_name}', full_name )

			para_A = item_array[5].to_s 
			para_A = para_A.sub('#{full_name}', full_name )

			# wash para B
			para_B = item_array[6].to_s
			# find vars and replace 
			para_B = para_B.sub('#{loan_rate}', records_array.stated_rate.to_s )
			para_B = para_B.sub('#{total_loan}', number_to_currency(records_array.total_amount) )
			st_date = records_array.repay_start.strftime("%B")
			para_B = para_B.sub('#{start_month}', st_date )	
			sign_to = item_array[9].to_s 
			sign_to = sign_to.sub('#{full_name}', full_name )

			tag_height = 14
			# step = up_one(step) 
			step = 0

			def get_page_loc(step, place_array, pdf, var_x, var_y)
				var_x = place_array[step][0]
				var_y = place_array[step][1]
					
				pdf.indent 320, 0 do
					pdf.stroke_color 'FFFF00'
					pdf.stroke_bounds
					pdf.text_box step.to_s + " - : " + place_array[step][0].to_s + " : w, " + place_array[step][1].to_s + " : h, ", {:size => 12, :color => "ff0000" }
					pdf.line_to [var_x, var_y]
				end
					# pdf.rectangle [var_x, var_y], 100, 200
				# end
			end
			
    		# page layout 
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# var_x = place_array[step][0]
				# var_y = place_array[step][1]	
				# pdf.bounding_box([ place_array[step][0], place_array[step][1] ] ), { :width => 200, :height => 300}) do
				# pdf.font "/app/assets/fonts/Spirax-Regular.ttf"
				# pdf.text item_array[step], {:color => "00ff00"}
				pdf.text say_date, {:color => "00ff00"}
				# pdf.text place_array[step][0].to_s
				# pdf.text place_array[step][1].to_s

				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
	        end
			
			# skip client info
			# step = up_one(step)  
			# pdf.bounding_box( [ place_array[step][0], place_array[step][1] ] ),{ :width => 200, :height => 30}) do
			pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 430, :height => 16}) do
				# get_page_loc(step, place_array, pdf);
				# pdf.text records_array.loan_name	
				# get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end
			step = up_one(step)

			# Client info 2
			pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
				pdf.text records_array.loan_name , {:color => "000000"}
				# get_page_loc(step, place_array, pdf, var_x, var_y);
				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )

			end
			step = up_one(step)  

			# info 3
			pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 16) do
			# 	pdf.text full_name_show , {:color => "000000"}
				pdf.text records_array.client_first_name , {:color => "000000"}
				get_page_loc(step, place_array, pdf, place_array[step][0], place_array[step][1] )
			end

			step = up_one(step)			
			# #Address 4
			pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
				pdf.font "OpenSans", size: 10 
				pdf.text comp_address + " \n" + comp_address_state
				get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			end

			# step = up_one(step)
			# # #intro 5
			# pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 16) do
			# 	pdf.text intro
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# #para 01 6
			# pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	# pdf.text item_array[step]
			# 	# pdf.text item_array[5]
			# 	pdf.text para_A 
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# # text item_array[step]
			# # end
			# step = up_one(step)
			# #para 02 7
			# pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 40) do
				
			# 	pdf.text para_B
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			
			# end
			# step = up_one(step) 
			# #para 03 8
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# # #ender 9
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step]
			# 	get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# # #sign to 10
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# # 	# pdf.text item_array[step]
			# 	pdf.text sign_to
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
			# step = up_one(step)
			# #sign from 11
			# pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 30) do
			# 	pdf.text item_array[step]
			# 	# get_page_loc(step, place_array, pdf, place_array[step][0] , place_array[step][1] )
			# end
		end







			# page 1 book 01
			# def page_letterB(pdf,item_array,place_array,records_array)
			# 	pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
			#            pdf.fill_color "ff0000"
			# 		pdf.transparent(1.0, 0.2) do 
			# 			pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
			# 		end
			#           pdf.fill_color "000000"
			#        end
			#        # page sign lines
			#        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
			# 		pdf.rectangle [110, 190], 180, 2
			# 		pdf.fill_rectangle [10, 100],0, 0
			# 		# pdf.fill_color "ff0000"
			# 		pdf.rectangle [310, 190], 180, 2
			# 		pdf.fill_rectangle [10, 100],0, 0
			# 		# pdf.fill_rectangle [240, 510],0, 0
			#        end

			#        step = 0
			#        def up_one(step)
			#        	step = step + 1
			#        	return step	
			#        end

			#     def number_to_currency(num)
			# 	  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			# 	end

			# 	current_date = records_array.client_first_name.to_s
			# 	my_string = item_array[0].to_s
			# 	groupName = Time.new
			# 	groupName = groupName.localtime.strftime('  %b %d, %Y')
			# 	say_date = my_string.gsub('#{current_date}', groupName )

			# 	full_name = records_array.client_first_name + " " + records_array.client_last_name

			# 	head_name = full_name
			# 	full_name_show = head_name.gsub('#{full_name}', head_name )

			# 	comp_address =  records_array.address_street;
			# 	comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			# 	intro = item_array[4]
			# 	intro = intro.gsub('#{full_name}', full_name )

			# 	para_A = item_array[5].to_s 
			# 	para_A = para_A.sub('#{full_name}', full_name )

			# 	para_B = item_array[6].to_s
			# 	para_B = para_B.sub('#{loan_rate}', records_array.stated_rate.to_s )

			# page 1 book 01
			# def page_letterB(pdf,item_array,place_array,records_array)
			# 	pdf.bounding_box([-30, 720], :width => 100, :height => 100, :at => [200, 550]) do
			#            pdf.fill_color "ff0000"
			# 		pdf.transparent(1.0, 0.2) do 
			# 			pdf.image open("app/assets/images/logo_page.png"), :fit => [600, 1000], :at => [0, 160]
			# 		end
			#           pdf.fill_color "000000"
			#        end
			#        # page sign lines
			#        pdf.bounding_box([0, 90],{ :width => 100, :height => 100 }) do
			# 		pdf.rectangle [110, 190], 180, 2
			# 		pdf.fill_rectangle [10, 100],0, 0
			# 		# pdf.fill_color "ff0000"
			# 		pdf.rectangle [310, 190], 180, 2
			# 		pdf.fill_rectangle [10, 100],0, 0
			# 		# pdf.fill_rectangle [240, 510],0, 0
			#        end

			#        step = 0
			#        def up_one(step)
			#        	step = step + 1
			#        	return step	
			#        end

			#     def number_to_currency(num)
			# 	  "$#{num.to_s.gsub(/\d(?=(...)+$)/, '\0,')}"
			# 	end

			# 	current_date = records_array.client_first_name.to_s
			# 	my_string = item_array[0].to_s
			# 	groupName = Time.new
			# 	groupName = groupName.localtime.strftime('  %b %d, %Y')
			# 	say_date = my_string.gsub('#{current_date}', groupName )

			# 	full_name = records_array.client_first_name + " " + records_array.client_last_name

			# 	head_name = full_name
			# 	full_name_show = head_name.gsub('#{full_name}', head_name )

			# 	comp_address =  records_array.address_street;
			# 	comp_address_state = records_array.address_city + ", " + records_array.address_state + " " + records_array.address_zip;

			# 	intro = item_array[4]
			# 	intro = intro.gsub('#{full_name}', full_name )

			# 	para_A = item_array[5].to_s 
			# 	para_A = para_A.sub('#{full_name}', full_name )

			# 	para_B = item_array[6].to_s
			# 	para_B = para_B.sub('#{loan_rate}', records_array.stated_rate.to_s )

			# 	para_B = para_B.sub('#{total_loan}', number_to_currency(records_array.total_amount) )		
			# 	st_date = records_array.repay_start.strftime("%B")
			# 	para_B = para_B.sub('#{start_month}', st_date )	

			# 	sign_to = item_array[9].to_s 
			# 	sign_to = sign_to.sub('#{full_name}', full_name )


			# 	pdf.bounding_box([ place_array[step][0], place_array[step][1]],{ :width => 200, :height => 300}) do
			#          pdf.text say_date, {:color => "00ff00"}
			#        end
			# 	step = up_one(step)

			# 	# 	Client info 2
			# 	pdf.bounding_box([  place_array[step][0], place_array[step][1] ], :width => 200, :height => 150) do

			# 		pdf.text records_array.loan_name , {:color => "000000"}
			# 	end
			# 	step = up_one(step)  

			# 	# info 3
			# 	pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 200, :height => 150) do
			# 		pdf.text full_name_show , {:color => "000000"}
			# 		# pdf.text records_array.client_last_name , {:color => "000000"}
			# 	end

			# 	step = up_one(step)			
			# 	#Address 4
			# 	pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 200, :height => 150) do
			# 		pdf.font "OpenSans", size: 10 
			# 		pdf.text comp_address
			# 		pdf.text comp_address_state
			# 	end

			# 	step = up_one(step)
			# 	#intro 5
			# 	pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 150) do
			# 		pdf.text intro
			# 	end
			# 	step = up_one(step)
			# 	#para 01 6
			# 	pdf.bounding_box([ place_array[step][0], place_array[step][1]], :width => 430, :height => 150) do
			# 		# pdf.text item_array[step]
			# 		# pdf.text item_array[5]
			# 		pdf.text para_A 
			# 	end
			# 	step = up_one(step)
			# 	#para 02 7
			# 	pdf.bounding_box([ place_array[step][0], place_array[step][1] ], :width => 430, :height => 150) do
			# 		pdf.text para_B
			# 		# pdf.text item_array[step]
			# 	end
			# 	step = up_one(step) 
			# 	#para 03 8
			# 	pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 150) do
			# 		pdf.text item_array[step]
			# 	end
			# 	step = up_one(step)
			# 	#ender 9
			# 	pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 150) do
			# 		pdf.text item_array[step]
			# 	end
			# 	step = up_one(step)
			# 	#sign to 10
			# 	pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 150) do
			# 		# pdf.text item_array[step]
			# 		pdf.text sign_to
			# 	end
			# 	step = up_one(step)
			# 	#sign from 11
			# 	pdf.bounding_box([place_array[step][0], place_array[step][1]], :width => 430, :height => 150) do
			# 		pdf.text item_array[10]
			# 	end
			# end











	end
end
