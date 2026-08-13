class = var_0_10000

local var_0_0 = "TimeSynchronizationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.TimeMgr.GetInstance()

	var_3.SetServerTime(var_1_2, var_1_1.timestamp, var_1_1.monday_0oclock_timestamp)

	getProxy = var_3
	BuildShipProxy = var_1_2

	local var_1_3 = var_3(var_1_2)

	var_3.setBuildShipState(var_1_3)

	return
end

return var_0_1
