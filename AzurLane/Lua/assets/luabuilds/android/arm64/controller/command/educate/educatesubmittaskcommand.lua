local var_0_0 = class("EducateSubmitTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27023, {
		id = var_1_0.id,
		system = var_1_0.system
	}, 27024, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(EducateProxy)

			if var_1_0.id == var_2_0:GetUnlockSecretaryTaskId() then
				var_2_0:SetSecretaryUnlock()
			end

			EducateHelper.UpdateDropsData(arg_2_0.awards)
			var_2_0:GetTaskProxy():RemoveTaskById(var_1_0.id)
			arg_1_0:sendNotification(GAME.EDUCATE_SUBMIT_TASK_DONE, {
				awards = arg_2_0.awards
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate submit task error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
