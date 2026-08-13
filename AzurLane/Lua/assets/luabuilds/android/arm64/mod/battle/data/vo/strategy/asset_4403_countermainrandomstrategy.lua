ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CounterMainRandomStrategy = var_0_10004("CounterMainRandomStrategy", var_0.Battle.RandomStrategy)

local var_0_4 = var_0.Battle.CounterMainRandomStrategy

var_0_4.__name = "CounterMainRandomStrategy"
var_0_4.FIX_FRONT = 0.5

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_4.GetStrategyType(arg_2_0)
	return var_0.Battle.BattleJoyStickAutoBot.COUNTER_MAIN
end

function var_0_4.generateTargetPoint(arg_3_0)
	local var_3_0 = arg_3_0._upperBound
	local var_3_1 = arg_3_0._lowerBound

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0._foeShipList) do
		local var_3_2 = iter_3_1:GetPosition().z

		math = var_1_10009
		var_3_0 = var_1_10009.min(var_3_2, var_3_0)
		math = var_1_10009
		var_3_1 = var_1_10009.max(var_3_2, var_3_1)
	end

	local var_3_3 = arg_3_0._fleetVO
	local var_3_4 = var_3.GetLeaderPersonality(var_3_3)
	local var_3_5 = var_0_4.FIX_FRONT
	local var_3_6 = var_3_4.rear_rate
	local var_3_7 = arg_3_0._fleetVO

	if var_6.GetIFF(var_3_7) == var_0_2.FRIENDLY_CODE then
		var_3_5 = 1 - var_3_5
		var_3_6 = 1 - var_3_6
	end

	local var_3_8 = arg_3_0._totalWidth * var_3_5 + arg_3_0._leftBound
	local var_3_9 = arg_3_0._totalWidth * var_3_6 + arg_3_0._leftBound
	local var_3_10 = arg_3_0._totalHeight * var_3_4.upper_rate + arg_3_0._lowerBound
	local var_3_11 = arg_3_0._totalHeight * var_3_4.lower_rate + arg_3_0._lowerBound

	math = var_10

	local var_3_12 = var_10.min(var_3_0, var_3_10)

	math = var_10

	local var_3_13 = var_10.max(var_3_1, var_3_11)
	local var_3_14

	math = var_1_10011

	local var_3_15 = var_1_10011.random(var_3_9, var_3_8)

	math = var_12

	local var_3_16 = var_12.random(var_3_13, var_3_12)

	Vector3 = var_13

	return (var_13(var_3_15, 0, var_3_16))
end

return
