class = var_0_10000

local var_0_0 = "EndToLearnCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 22004, {
		type = 0
	}, 22005, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			NavalAcademyProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			getProxy = var_2_10002
			BayProxy = var_2_10003

			local var_2_1 = var_2_10002(var_2_10003)
			local var_2_2 = var_2_0:getCourse()
			local var_2_3 = var_2_10003.getConfig(var_2_2, "name_show")
			local var_2_4 = var_2_10003.proficiency

			math = var_6
			var_2_10003.proficiency = var_6.max(var_2_4 - arg_2_0.proficiency, 0)

			local var_2_5 = {}
			local var_2_6 = {}

			_ = var_2_10009

			var_2_10009.each(arg_2_0.awards, function(arg_3_0)
				var_2_5[arg_3_0.ship_id] = arg_3_0.exp
				var_2_6[arg_3_0.ship_id] = arg_3_0.energy

				return
			end)

			_ = var_9

			local var_2_7 = var_9.map(var_2_10003.students, function(arg_4_0)
				local var_4_0 = var_2_1

				return var_1.getShipById(var_4_0, arg_4_0)
			end)

			Clone = var_10

			local var_2_8 = var_10(var_2_7)

			_ = var_11

			var_11.each(var_2_8, function(arg_5_0)
				local var_5_0 = arg_5_0
				local var_5_1 = arg_5_0.addExp
				local var_5_2

				if not var_2_5[arg_5_0.id] then
					var_5_2 = 0
				end

				var_5_1(var_5_0, var_5_2)

				local var_5_3 = arg_5_0
				local var_5_4 = arg_5_0.cosumeEnergy
				local var_5_5

				if not var_2_6[arg_5_0.id] then
					var_5_5 = 0
				end

				var_5_4(var_5_3, var_5_5)

				local var_5_6 = var_2_1

				var_1.updateShip(var_5_6, arg_5_0)

				return
			end)

			var_2_10003.students = {}
			var_2_10003.timestamp = 0

			var_2_0:setCourse(var_2_10003)

			local var_2_9 = arg_1_0
			local var_2_10 = var_11.sendNotification

			GAME = var_13

			var_2_10(var_2_9, var_13.CLASS_STOP_COURSE_DONE, {
				title = var_2_3,
				oldProficiency = var_2_4,
				newProficiency = var_6,
				oldStudents = var_2_7,
				newStudents = var_2_8
			})
		else
			pg = var_2_0

			local var_2_11 = var_2_0.TipsMgr.GetInstance()
			local var_2_12 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_12(var_2_11, var_2_10003("lesson_endToLearn", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
