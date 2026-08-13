class = var_0_10000

local var_0_0 = "SetSecondaryPasswordSettingsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.UIMgr.GetInstance()

	var_3.LoadingOn(var_1_1)

	pg = var_3

	local var_1_2 = var_3.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 11607, {
		password = var_1_0.pwd,
		system_list = var_1_0.settings
	}, 11608, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_2_0)

		if arg_2_0.result == 0 then
			getProxy = var_1
			SecondaryPWDProxy = var_2_0
			var_2_10004 = var_1(var_2_0)

			var_1.OnSettingsChange(var_2_10004, var_1_0)
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_2_10004

		var_2_2(var_2_1, var_2_10004.SET_PASSWORD_SETTINGS_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_1
