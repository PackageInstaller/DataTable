class = var_0_10000

local var_0_0 = "StartToLearnCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).students

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 22002, {
		students = var_1_1
	}, 22003, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NavalAcademyProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getCourse(var_2_10004)

			var_2_0.students = var_1_1
			pg = var_3

			local var_2_1 = var_3.TimeMgr.GetInstance()

			var_2_0.timestamp = var_3.GetServerTime(var_2_1)

			var_1:setCourse(var_2_0)

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = var_6

			var_2_3(var_2_2, var_6.CLASS_START_COURSE_DONE)
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_5(var_2_4, var_2_10004("lesson_startToLearn", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
