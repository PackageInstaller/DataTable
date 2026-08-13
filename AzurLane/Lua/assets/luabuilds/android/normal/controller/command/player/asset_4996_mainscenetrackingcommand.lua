class = var_0_10000

local var_0_0 = "MainSceneTrackingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().trackType
	local var_1_1 = var_2.arg1
	local var_1_2 = var_2.arg2
	local var_1_3 = var_2.arg3
	local var_1_4 = var_2.arg4

	pg = var_1_10008

	local var_1_5 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 11029, {
		track_typ = var_1_0,
		int_arg1 = var_1_1,
		int_arg2 = var_1_2,
		int_arg3 = var_1_3,
		str_arg1 = var_1_4
	})

	return
end

return var_0_1
