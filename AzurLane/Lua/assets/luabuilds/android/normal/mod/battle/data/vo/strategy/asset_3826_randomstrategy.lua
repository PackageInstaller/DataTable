ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.RandomStrategy = var_0_10004("RandomStrategy", var_0.Battle.BattleJoyStickBotBaseStrategy)

local var_0_4 = var_0.Battle.RandomStrategy

var_0_4.__name = "RandomStrategy"
var_0_4.STOP_DURATION_MAX = 20
var_0_4.STOP_DURATION_MIN = 10
var_0_4.MOVE_DURATION_MAX = 60
var_0_4.MOVE_DURATION_MIN = 20

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._stopCount = 0
	arg_1_0._moveCount = 0
	Vector3 = var_2
	arg_1_0._speed = var_2.zero
	Vector3 = var_2
	arg_1_0._speedCross = var_2.zero

	return
end

function var_0_4.GetStrategyType(arg_2_0)
	return var_0.Battle.BattleJoyStickAutoBot.RANDOM
end

function var_0_4.Input(arg_3_0, arg_3_1, arg_3_2)
	var_0_4.super.Input(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:shiftTick(0, 10)

	return
end

Vector3 = var_4

local var_0_5 = var_4.up

function var_0_4._moveTick(arg_4_0)
	if arg_4_0._moveCount <= 0 then
		arg_4_0:shiftTick(-1)
	else
		arg_4_0._moveCount = arg_4_0._moveCount - 1

		local var_4_0 = arg_4_0._speed
		local var_4_1 = var_1.Magnitude(var_4_0)
		local var_4_2 = arg_4_0._speedCross
		local var_4_3 = var_2.Copy(var_4_2, var_0_5)
		local var_4_4 = var_2.Cross2(var_4_3, arg_4_0._speed)

		arg_4_0._speedCross = var_2.Mul(var_4_4, arg_4_0._crossAcc / var_4_1)

		local var_4_5 = arg_4_0._speed

		arg_4_0._speed = var_2.Add(var_4_5, arg_4_0._speedCross)
		arg_4_0._hrz = arg_4_0._speed.x
		arg_4_0._vtc = arg_4_0._speed.z
	end

	return
end

function var_0_4._stopTick(arg_5_0)
	if arg_5_0._stopCount <= 0 then
		arg_5_0:shiftTick(0, 10)
	else
		arg_5_0._stopCount = arg_5_0._stopCount - 1
	end

	return
end

function var_0_4.shiftTick(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._stopWeight = arg_6_1 or arg_6_0._stopWeight
	arg_6_0._moveWeight = arg_6_2 or arg_6_0._moveWeight
	math = var_3

	local var_6_0 = var_3.random(arg_6_0._stopWeight, arg_6_0._moveWeight)
	local var_6_2

	if 0 <= var_6_0 then
		arg_6_0._moveWeight = arg_6_0._moveWeight - 1
		math = var_6_2
		arg_6_0._moveCount = var_6_2.random(var_0_4.MOVE_DURATION_MIN, var_0_4.MOVE_DURATION_MAX)
		arg_6_0._targetPoint = arg_6_0:generateTargetPoint()

		local var_6_1 = arg_6_0._motionVO

		var_6_2 = var_6_2.GetPos(var_6_1)

		local var_6_3, var_6_4 = arg_6_0.getDirection(var_6_2, arg_6_0._targetPoint)

		arg_6_0._speed.x = var_6_3

		local var_6_5 = arg_6_0._speed

		var_6_5.z = var_6_4
		math = var_6_5
		arg_6_0._crossAcc = var_6_5.random(-100, 100) / 16
		arg_6_0.analysis = arg_6_0._moveTick
	else
		math = var_6_2
		arg_6_0._stopCount = var_6_2.random(var_0_4.STOP_DURATION_MIN, var_0_4.STOP_DURATION_MAX)
		arg_6_0.analysis = var_0_4._stopTick
		arg_6_0._hrz = 0
		arg_6_0._vtc = 0
	end

	return
end

function var_0_4.generateTargetPoint(arg_7_0)
	local var_7_0 = arg_7_0._fleetVO
	local var_7_1 = var_1.GetLeaderPersonality(var_7_0).front_rate
	local var_7_2 = var_1.rear_rate
	local var_7_3 = arg_7_0._fleetVO

	if var_4.GetIFF(var_7_3) == var_0_2.FRIENDLY_CODE then
		var_7_1 = 1 - var_7_1
		var_7_2 = 1 - var_7_2
	end

	local var_7_4 = arg_7_0._totalWidth * var_7_1 + arg_7_0._leftBound
	local var_7_5 = arg_7_0._totalWidth * var_7_2 + arg_7_0._leftBound
	local var_7_6 = arg_7_0._totalHeight * var_1.upper_rate + arg_7_0._lowerBound
	local var_7_7 = arg_7_0._totalHeight * var_1.lower_rate + arg_7_0._lowerBound
	local var_7_8

	math = var_1_10009

	local var_7_9 = var_1_10009.random(var_7_5, var_7_4)

	math = var_10

	local var_7_10 = var_10.random(var_7_7, var_7_6)

	Vector3 = var_11

	return (var_11(var_7_9, 0, var_7_10))
end

return
