class = var_0_10000

local var_0_0 = "ConfirmSecondaryPasswordCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.UIMgr.GetInstance()

	var_3.LoadingOn(var_1_2)

	pg = var_3

	local var_1_3 = var_3.ConnectionMgr.GetInstance()

	var_3.Send(var_1_3, 11609, {
		password = var_1_1.pwd
	}, 11610, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_2_0)

		if arg_2_0.result == 0 then
			getProxy = var_1
			SecondaryPWDProxy = var_2_0
			var_2_10003 = var_1(var_2_0)

			local var_2_1 = var_1.getRawData(var_2_10003)

			var_2_1.state = 2
			var_2_1.fail_cd = nil
			var_2_1.fail_count = 0
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_1.sendNotification

		GAME = var_2_10003

		var_2_3(var_2_2, var_2_10003.CONFIRM_PASSWORD_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_1
