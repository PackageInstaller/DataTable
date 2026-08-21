local var_0_0 = class("IslandFish", import("model.vo.BaseVO"))

var_0_0.CUP_STATE_NONE = 0
var_0_0.CUP_STATE_MIN = 1
var_0_0.CUP_STATE_MAX = 2
var_0_0.CUP_STATE_NIN_AND_MAX = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.fish_id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.minWeight = arg_1_1.min_weight
	arg_1_0.maxWeight = arg_1_1.max_weight
	arg_1_0.cupState = arg_1_1.gold_state or var_0_0.CUP_STATE_NONE

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_fish
end

function var_0_0.GetMinWeight(arg_3_0)
	return arg_3_0.minWeight
end

function var_0_0.GetMaxWeight(arg_4_0)
	return arg_4_0.maxWeight
end

function var_0_0.SetWeight(arg_5_0, arg_5_1)
	if arg_5_1 > arg_5_0.maxWeight then
		arg_5_0.maxWeight = arg_5_1
	elseif arg_5_1 < arg_5_0.minWeight then
		arg_5_0.minWeight = arg_5_1
	end

	return
end

function var_0_0.ReachMinCup(arg_6_0)
	return arg_6_0.cupState == var_0_0.CUP_STATE_NIN_AND_MAX or arg_6_0.cupState == var_0_0.CUP_STATE_MIN
end

function var_0_0.ReachMaxCup(arg_7_0)
	return arg_7_0.cupState == var_0_0.CUP_STATE_NIN_AND_MAX or arg_7_0.cupState == var_0_0.CUP_STATE_MAX
end

function var_0_0.SetCupState(arg_8_0, arg_8_1)
	if arg_8_0.cupState == var_0_0.CUP_STATE_NIN_AND_MAX then
		return
	end

	if arg_8_1 == 1 then
		if arg_8_0.cupState == var_0_0.CUP_STATE_MAX then
			arg_8_0.cupState = var_0_0.CUP_STATE_NIN_AND_MAX or var_0_0.CUP_STATE_MIN

			goto label_8_0

			::label_8_0::

			if arg_8_1 == 2 then
				if arg_8_0.cupState == var_0_0.CUP_STATE_MIN then
					arg_8_0.cupState = var_0_0.CUP_STATE_NIN_AND_MAX or var_0_0.CUP_STATE_MAX

					return
				end
			end
		end
	end
end

return var_0_0
