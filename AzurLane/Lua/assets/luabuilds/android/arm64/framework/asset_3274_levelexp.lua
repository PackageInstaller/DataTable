local function var_0_0(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or "exp"

	local var_1_0

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_0.all) do
		local var_1_1 = arg_1_0[iter_1_1]

		var_1_1.level0 = iter_1_0 - 1
		var_1_1.level1 = iter_1_0

		if not var_1_0 then
			var_1_1[arg_1_1 .. "_start"] = 0
		else
			var_1_1[arg_1_1 .. "_start"] = var_1_0[arg_1_1 .. "_start"] + var_1_0[arg_1_1 .. "_interval"]
		end

		var_1_1[arg_1_1 .. "_interval"] = var_1_1[arg_1_1]
		var_1_1[arg_1_1 .. "_end"] = var_1_1[arg_1_1 .. "_start"] + var_1_1[arg_1_1] - 1
		var_1_0 = var_1_1
	end

	return
end

local var_0_1 = prepareLevelExpConfig

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or "exp"

	local var_2_0

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_0.all) do
		if arg_2_1 < arg_2_0[iter_2_1][arg_2_2 .. "_end"] then
			return var_2_0
		end
	end

	return var_2_0
end

local var_0_3 = getConfigFromTotalExp

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_0[arg_3_1 + 1] then
		var_3_0 = arg_3_0[#arg_3_0]
	end

	return var_3_0
end

local var_0_5 = getConfigFromLevel0

local function var_0_6(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0[arg_4_1] then
		var_4_0 = arg_4_0[#arg_4_0]
	end

	return var_4_0
end

local var_0_7 = getConfigFromLevel1

local function var_0_8(arg_5_0, arg_5_1)
	getConfigFromLevel1 = var_1_10002
	pg = var_1_10004

	local var_5_0 = var_1_10002(var_1_10004.ship_level, arg_5_1)

	ShipRarity = var_1_10003

	if arg_5_0 >= var_1_10003.SSR then
		return var_5_0.exp_ur
	else
		return var_5_0.exp
	end

	return
end

prepareLevelExpConfig = getExpByRarityFromLv1
pg = var_0_10002

var_0(var_0_10002.user_level)

prepareLevelExpConfig = var_0
pg = var_2

var_0(var_2.ship_level)

prepareLevelExpConfig = var_0
pg = var_2

var_0(var_2.ship_level, "exp_ur")

return
