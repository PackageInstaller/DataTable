local var_0_0 = class("EducateSetTargetCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback
	local var_1_2 = var_1_0.open

	pg.ConnectionMgr.GetInstance():Send(27019, {
		id = var_1_0.id
	}, 27020, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(EducateProxy)

			var_2_0:GetTaskProxy():UpdateTargetAwardStatus(false)
			var_2_0:GetTaskProxy():SetTarget(var_1_0.id)
			var_2_0:UpdateGameStatus()
			arg_1_0:sendNotification(GAME.EDUCATE_SET_TARGET_DONE, {
				autoOpen = var_1_2
			})

			if var_1_1 then
				var_1_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate set target error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
