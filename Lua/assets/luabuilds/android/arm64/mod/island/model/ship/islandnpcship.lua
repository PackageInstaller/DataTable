local var_0_0 = class("IslandNpcShip", import(".IslandShip"))

function var_0_0.GetState(arg_1_0)
	return var_0_0.STATE_NORMAL
end

function var_0_0.GetEnergy(arg_2_0)
	return arg_2_0.maxEnerey
end

function var_0_0.GetCurrentEnergy(arg_3_0)
	return arg_3_0.maxEnerey
end

return var_0_0
