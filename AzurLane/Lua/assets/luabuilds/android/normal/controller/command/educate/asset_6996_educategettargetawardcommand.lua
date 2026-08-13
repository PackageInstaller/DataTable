class = var_0_10000

local var_0_0 = "EducateGetTargetAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback
	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 27035, {
		type = 0
	}, 27036, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			EducateHelper = var_2_3

			var_2_3.UpdateDropsData(arg_2_0.drops)

			getProxy = var_2_3
			EducateProxy = var_2

			local var_2_0 = var_2_3(var_2)
			local var_2_1 = var_2_3.GetTaskProxy(var_2_0)

			var_2_3.UpdateTargetAwardStatus(var_2_1, true)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10003

			var_2_3(var_2_2, var_2_10003.EDUCATE_GET_TARGET_AWARD_DONE, {
				awards = arg_2_0.drops
			})
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("get target award error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
