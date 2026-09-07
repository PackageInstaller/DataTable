ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.RandomStrategy = class("RandomStrategy", ys.Battle.BattleJoyStickBotBaseStrategy)

local var_0_3 = ys.Battle.RandomStrategy

ys.Battle.RandomStrategy.__name = "RandomStrategy"
ys.Battle.RandomStrategy.STOP_DURATION_MAX = 20
ys.Battle.RandomStrategy.STOP_DURATION_MIN = 10
ys.Battle.RandomStrategy.MOVE_DURATION_MAX = 60
ys.Battle.RandomStrategy.MOVE_DURATION_MIN = 20

function ys.Battle.RandomStrategy.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._stopCount = 0
	arg_1_0._moveCount = 0
	arg_1_0._speed = Vector3.zero
	arg_1_0._speedCross = Vector3.zero

	return
end

function ys.Battle.RandomStrategy.GetStrategyType(arg_2_0)
	return var_0_0.Battle.BattleJoyStickAutoBot.RANDOM
end

function ys.Battle.RandomStrategy:Input(arg_3_1, arg_3_2)
	var_0_3.super.Input(self, arg_3_1, arg_3_2)
	self:shiftTick(0, 10)

	return
end

local var_0_4 = Vector3.up

function ys.Battle.RandomStrategy:_moveTick()
	if self._moveCount <= 0 then
		self:shiftTick(-1)
	else
		self._moveCount = self._moveCount - 1
		self._speedCross = self._speedCross:Copy(var_0_4):Cross2(self._speed):Mul(self._crossAcc / self._speed:Magnitude())
		self._speed = self._speed:Add(self._speedCross)
		self._hrz = self._speed.x
		self._vtc = self._speed.z
	end

	return
end

function ys.Battle.RandomStrategy:_stopTick()
	if self._stopCount <= 0 then
		self:shiftTick(0, 10)
	else
		self._stopCount = self._stopCount - 1
	end

	return
end

function ys.Battle.RandomStrategy:shiftTick(arg_6_1, arg_6_2)
	self._stopWeight = arg_6_1 or self._stopWeight
	self._moveWeight = arg_6_2 or self._moveWeight

	if math.random(self._stopWeight, self._moveWeight) >= 0 then
		self._moveWeight = self._moveWeight - 1
		self._moveCount = math.random(var_0_3.MOVE_DURATION_MIN, var_0_3.MOVE_DURATION_MAX)
		self._targetPoint = self:generateTargetPoint()

		local var_6_0, var_6_1 = self.getDirection(self._motionVO:GetPos(), self._targetPoint)

		self._speed.x = var_6_0
		self._speed.z = var_6_1
		self._crossAcc = math.random(-100, 100) / 16
		self.analysis = self._moveTick
	else
		self._stopCount = math.random(var_0_3.STOP_DURATION_MIN, var_0_3.STOP_DURATION_MAX)
		self.analysis = var_0_3._stopTick
		self._hrz = 0
		self._vtc = 0
	end

	return
end

function ys.Battle.RandomStrategy:generateTargetPoint()
	local var_7_0 = self._fleetVO:GetLeaderPersonality()
	local var_7_1 = var_7_0.front_rate
	local var_7_2 = var_7_0.rear_rate

	if self._fleetVO:GetIFF() == var_0_2.FRIENDLY_CODE then
		var_7_1 = 1 - var_7_1
		var_7_2 = 1 - var_7_2
	end

	return (Vector3(math.random(self._totalWidth * var_7_2 + self._leftBound, self._totalWidth * var_7_1 + self._leftBound), 0, (math.random(self._totalHeight * var_7_0.lower_rate + self._lowerBound, self._totalHeight * var_7_0.upper_rate + self._lowerBound))))
end

return
