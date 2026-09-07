local EducateGetTargetAwardCommand = class("EducateGetTargetAwardCommand", pm.SimpleCommand)

function EducateGetTargetAwardCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27035, {
		type = 0
	}, 27036, function(arg_2_0)
		if arg_2_0.result == 0 then
			EducateHelper.UpdateDropsData(arg_2_0.drops)
			getProxy(EducateProxy):GetTaskProxy():UpdateTargetAwardStatus(true)
			self:sendNotification(GAME.EDUCATE_GET_TARGET_AWARD_DONE, {
				awards = arg_2_0.drops
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("get target award error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateGetTargetAwardCommand
