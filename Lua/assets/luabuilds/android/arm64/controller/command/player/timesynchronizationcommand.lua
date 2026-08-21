local var_0_0 = class("TimeSynchronizationCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.TimeMgr.GetInstance():SetServerTime(var_1_0.timestamp, var_1_0.monday_0oclock_timestamp)
	getProxy(BuildShipProxy):setBuildShipState()

	return
end

return var_0_0
