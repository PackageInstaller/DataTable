local var_0_0 = class("MainSceneTrackingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11029, {
		track_typ = var_1_0.trackType,
		int_arg1 = var_1_0.arg1,
		int_arg2 = var_1_0.arg2,
		int_arg3 = var_1_0.arg3,
		str_arg1 = var_1_0.arg4
	})

	return
end

return var_0_0
