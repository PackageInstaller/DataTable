class = var_0_10000

local var_0_0 = "FetchSecondaryPasswordCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOn(var_1_0)

	pg = var_2

	local var_1_1 = var_2.ConnectionMgr.GetInstance()

	var_2.Send(var_1_1, 11603, {
		type = 1
	}, 11604, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_2_0)

		getProxy = var_1
		SecondaryPWDProxy = var_2_0

		local var_2_1 = var_1(var_2_0)

		var_1.SetData(var_2_1, arg_2_0)

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.FETCH_PASSWORD_STATE_DONE, arg_2_0)

		return
	end)

	return
end

return var_0_1
