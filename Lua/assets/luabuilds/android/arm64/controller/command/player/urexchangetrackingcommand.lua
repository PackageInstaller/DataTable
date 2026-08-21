local var_0_0 = class("UrExchangeTrackingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11212, {
		track_typ = var_1_0.trackType,
		ship_tid = var_1_0.arg1,
		from = var_1_0.arg2
	})

	return
end

return var_0_0
