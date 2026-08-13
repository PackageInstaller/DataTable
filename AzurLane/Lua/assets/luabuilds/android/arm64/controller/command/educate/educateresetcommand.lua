class = var_0_10000

local var_0_0 = "EducateResetCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1

	var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback
	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 27029, {
		type = 1
	}, 27030, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			EducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.Reset(var_2_0, function()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.sendNotification

				GAME = var_3_10003

				var_3_1(var_3_0, var_3_10003.EDUCATE_REFRESH_DONE)

				return
			end)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_2(var_2_1, var_2_10004("educate reset error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
