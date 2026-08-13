class = var_0_10000

local var_0_0 = "IslandNpcShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandShip"))

function var_0_1.GetState(arg_1_0)
	return var_0_1.STATE_NORMAL
end

function var_0_1.GetEnergy(arg_2_0)
	return arg_2_0.maxEnerey
end

function var_0_1.GetCurrentEnergy(arg_3_0)
	return arg_3_0.maxEnerey
end

return var_0_1
