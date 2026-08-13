class = var_0_10000

local var_0_0 = "IslandFish"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.CUP_STATE_NONE = 0
var_0_1.CUP_STATE_MIN = 1
var_0_1.CUP_STATE_MAX = 2
var_0_1.CUP_STATE_NIN_AND_MAX = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.fish_id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.minWeight = arg_1_1.min_weight
	arg_1_0.maxWeight = arg_1_1.max_weight

	local var_1_0

	if not arg_1_1.gold_state then
		var_1_0 = var_0_1.CUP_STATE_NONE
	end

	arg_1_0.cupState = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_fish
end

function var_0_1.GetMinWeight(arg_3_0)
	return arg_3_0.minWeight
end

function var_0_1.GetMaxWeight(arg_4_0)
	return arg_4_0.maxWeight
end

function var_0_1.SetWeight(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0.maxWeight then
		arg_5_0.maxWeight = arg_5_1
	elseif arg_5_1 < arg_5_0.minWeight then
		arg_5_0.minWeight = arg_5_1
	end

	return
end

function var_0_1.ReachMinCup(arg_6_0)
	return arg_6_0.cupState == var_0_1.CUP_STATE_NIN_AND_MAX or arg_6_0.cupState == var_0_1.CUP_STATE_MIN
end

function var_0_1.ReachMaxCup(arg_7_0)
	return arg_7_0.cupState == var_0_1.CUP_STATE_NIN_AND_MAX or arg_7_0.cupState == var_0_1.CUP_STATE_MAX
end

function var_0_1.SetCupState(arg_8_0, arg_8_1)
	if arg_8_0.cupState == var_0_1.CUP_STATE_NIN_AND_MAX then
		return
	end

	if arg_8_1 == 1 then
		local var_8_0

		if arg_8_0.cupState ~= var_0_1.CUP_STATE_MAX or not var_0_1.CUP_STATE_NIN_AND_MAX then
			var_8_0 = var_0_1.CUP_STATE_MIN
		end

		arg_8_0.cupState = var_8_0
	elseif arg_8_1 == 2 then
		local var_8_1

		if arg_8_0.cupState ~= var_0_1.CUP_STATE_MIN or not var_0_1.CUP_STATE_NIN_AND_MAX then
			var_8_1 = var_0_1.CUP_STATE_MAX
		end

		arg_8_0.cupState = var_8_1
	end

	return
end

return var_0_1
