local TrackCommand = class("TrackCommand", pm.SimpleCommand)

function TrackCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(10993, {
		action_arg = 0,
		action_system = var_1_0.system,
		action_id = var_1_0.id,
		action_des = var_1_0.desc
	})

	return
end

return TrackCommand
