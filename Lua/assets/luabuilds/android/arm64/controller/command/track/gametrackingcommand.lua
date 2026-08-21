local var_0_0 = class("GameTrackingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(10991, {
		infos = arg_1_1:getBody().infos
	})

	return
end

return var_0_0
