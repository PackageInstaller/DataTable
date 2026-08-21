local var_0_0 = class("StartToLearnCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(22002, {
		students = arg_1_1:getBody().students
	}, 22003, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NavalAcademyProxy)
			local var_2_1 = var_2_0:getCourse()

			var_2_1.students = var_0
			var_2_1.timestamp = pg.TimeMgr.GetInstance():GetServerTime()

			var_2_0:setCourse(var_2_1)
			arg_1_0:sendNotification(GAME.CLASS_START_COURSE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("lesson_startToLearn", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
