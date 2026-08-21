local var_0_0 = class("TrackCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(10993, {
		action_arg = 0,
		action_system = var_1_0.system,
		action_id = var_1_0.id,
		action_des = var_1_0.desc
	})

	return
end

return var_0_0
