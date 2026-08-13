class = var_0_10000

local var_0_0 = "TimeSynchronizationCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.TimeMgr.GetInstance()

	var_3.SetServerTime(var_1_1, var_1_0.timestamp, var_1_0.monday_0oclock_timestamp)

	getProxy = var_3
	BuildShipProxy = var_1_1

	local var_1_2 = var_3(var_1_1)

	var_3.setBuildShipState(var_1_2)

	return
end

return var_0_1
