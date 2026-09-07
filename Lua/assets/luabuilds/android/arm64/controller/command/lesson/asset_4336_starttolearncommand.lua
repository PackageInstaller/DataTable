local StartToLearnCommand = class("StartToLearnCommand", pm.SimpleCommand)

function StartToLearnCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().students

	pg.ConnectionMgr.GetInstance():Send(22002, {
		students = var_1_0
	}, 22003, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NavalAcademyProxy)
			local var_2_1 = var_2_0:getCourse()

			var_2_1.students = var_1_0
			var_2_1.timestamp = pg.TimeMgr.GetInstance():GetServerTime()

			var_2_0:setCourse(var_2_1)
			self:sendNotification(GAME.CLASS_START_COURSE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("lesson_startToLearn", arg_2_0.result))
		end

		return
	end)

	return
end

return StartToLearnCommand
