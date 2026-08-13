class = var_0_10000

local var_0_0 = "EducateSubmitTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1

	var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback
	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 27023, {
		id = var_2.id,
		system = var_2.system
	}, 27024, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			EducateProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)

			if var_0.id == var_2_0:GetUnlockSecretaryTaskId() then
				var_2_10004 = var_2_0

				var_2_0.SetSecretaryUnlock(var_2_10004)
			end

			EducateHelper = var_2

			var_2.UpdateDropsData(arg_2_0.awards)

			var_2_10004 = var_2_0
			var_2_10004 = var_2_0.GetTaskProxy(var_2_10004)

			var_2.RemoveTaskById(var_2_10004, var_0.id)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.EDUCATE_SUBMIT_TASK_DONE, {
				awards = arg_2_0.awards
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_3(var_2_2, var_2_10004("educate submit task error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
