class = var_0_10000

local var_0_0 = "GetShipCntCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 11800, {
		type = 0
	}, 11801, function(arg_2_0)
		var_1_1(arg_2_0.ship_count)

		return
	end)

	return
end

return var_0_1
