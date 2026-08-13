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
		local var_3_2 = iter_3_1
		local var_3_3 = iter_3_1.GetPosition(var_3_2).z

		math = var_3_2
		var_3_0 = var_3_2.min(var_3_3, var_3_0)
		math = var_9
		var_3_1 = var_9.max(var_3_3, var_3_1)
	end

	local var_3_4 = arg_3_0._fleetVO
	local var_3_5 = var_3.GetLeaderPersonality(var_3_4)
	local var_3_6 = var_0_4.FIX_FRONT
	local var_3_7 = var_3_5.rear_rate
	local var_3_8 = arg_3_0._fleetVO

	if var_6.GetIFF(var_3_8) == var_0_2.FRIENDLY_CODE then
		var_3_6 = 1 - var_3_6
		var_3_7 = 1 - var_3_7
	end

	local var_3_9 = arg_3_0._totalWidth * var_3_6 + arg_3_0._leftBound
	local var_3_10 = arg_3_0._totalWidth * var_3_7 + arg_3_0._leftBound
	local var_3_11 = arg_3_0._totalHeight * var_3_5.upper_rate + arg_3_0._lowerBound
	local var_3_12 = arg_3_0._totalHeight * var_3_5.lower_rate + arg_3_0._lowerBound

	math = var_10

	local var_3_13 = var_10.min(var_3_0, var_3_11)

	math = var_10

	local var_3_14 = var_10.max(var_3_1, var_3_12)
	local var_3_15

	math = var_11

	local var_3_16 = var_11.random(var_3_10, var_3_9)

	math = var_12

	local var_3_17 = var_12.random(var_3_14, var_3_13)

	Vector3 = var_13

	return (var_13(var_3_16, 0, var_3_17))
end

return
