class = var_0_10000

local var_0_0 = "CourtYardVisitorShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardShip"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.name = arg_1_2.name
	arg_1_0.inimacy = 0
	arg_1_0.coin = 0

	return
end

function var_0_1.GetName(arg_2_0)
	return arg_2_0.name
end

function var_0_1.GetShipType(arg_3_0)
	CourtYardConst = var_1_10001

	return var_1_10001.SHIP_TYPE_OTHER
end

return var_0_1
