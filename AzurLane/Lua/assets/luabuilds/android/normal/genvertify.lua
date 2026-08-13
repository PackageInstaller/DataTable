local function var_0_0()
	return 0
end

local var_0_1 = GetBattleCheck

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = 2621
	local var_2_1 = 3527

	GetBattleCheck = var_1_10005

	local var_2_2 = var_1_10005()

	math = var_1_10006
	arg_2_0 = var_1_10006.floor(arg_2_0 % var_2_0 * (arg_2_1 % var_2_0) % var_2_0 + arg_2_2)
	tostring = var_6
	math = var_7

	local var_2_3 = var_6(var_7.floor(var_2_2 % var_2_1 * (arg_2_1 % var_2_1) % (var_2_1 + arg_2_0)))

	return arg_2_0, var_2_3
end

ys = GetBattleCheckResult
var_0.BattleShipLevelVertify = {}

return
