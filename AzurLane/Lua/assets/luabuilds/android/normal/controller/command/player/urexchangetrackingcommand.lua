class = var_0_10000

local var_0_0 = "UrExchangeTrackingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().trackType
	local var_1_1 = var_2.arg1
	local var_1_2 = var_2.arg2

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 11212, {
		track_typ = var_1_0,
		ship_tid = var_1_1,
		from = var_1_2
	})

	return
end

return var_0_1
