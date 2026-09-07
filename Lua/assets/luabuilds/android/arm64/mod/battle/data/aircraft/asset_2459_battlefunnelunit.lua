ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleTargetChoise

ys.Battle.BattleFunnelUnit = class("BattleFunnelUnit", ys.Battle.BattleAircraftUnit)
ys.Battle.BattleFunnelUnit.__name = "BattleFunnelUnit"

local var_0_4 = ys.Battle.BattleFunnelUnit

ys.Battle.BattleFunnelUnit.STOP_STATE = "STOP_STATE"
ys.Battle.BattleFunnelUnit.MOVE_STATE = "MOVE_STATE"
ys.Battle.BattleFunnelUnit.CRASH_STATE = "CRASH_STATE"

function ys.Battle.BattleFunnelUnit.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._dir = var_0_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0_0.Battle.BattleConst.UnitType.FUNNEL_UNIT

	return
end

function ys.Battle.BattleFunnelUnit:Update(arg_2_1)
	self:updateExist()
	self:updatePatrol(arg_2_1)

	return
end

function ys.Battle.BattleFunnelUnit:updateExist()
	if not self._existStartTime then
		return
	end

	if self._existStartTime + self._existDuration < pg.TimeMgr.GetInstance():GetCombatTime() then
		self:changePartolState(var_0_4.CRASH_STATE)
	end

	return
end

function ys.Battle.BattleFunnelUnit:UpdateWeapon()
	for iter_4_0, iter_4_1 in ipairs(self:GetWeapon()) do
		iter_4_1:Update()
	end

	return
end

function ys.Battle.BattleFunnelUnit:SetMotherUnit(arg_5_1)
	var_0_4.super.SetMotherUnit(self, arg_5_1)

	self._upperBound, self._lowerBound, self._leftBound, self._rightBound = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetBoundByIFF(self:GetIFF() * -1)

	return
end

function ys.Battle.BattleFunnelUnit:SetTemplate(arg_6_1)
	var_0_4.super.SetTemplate(self, arg_6_1)

	self._existDuration = arg_6_1.funnel_behavior.exist
	self._stayDuration = arg_6_1.funnel_behavior.stay
	self._frontOffset = arg_6_1.funnel_behavior.front or 0
	self._rearOffset = arg_6_1.funnel_behavior.rear or 0
	self.changeToStopState = self:GetWeapon()[1] and var_0_4.stopState or var_0_4.nonWeaponStopState

	if self:GetIFF() == var_0_1.FRIENDLY_CODE then
		self._leftBound = self._leftBound + self._rearOffset
		self._rightBound = self._rightBound + self._frontOffset
	else
		self._leftBound = self._leftBound - self._frontOffset
		self._rightBound = self._rightBound - self._rearOffset
	end

	return
end

function ys.Battle.BattleFunnelUnit:changePartolState(arg_7_1)
	if arg_7_1 == var_0_4.MOVE_STATE then
		self:changeToMoveState()
	elseif arg_7_1 == var_0_4.STOP_STATE then
		self:changeToStopState()
	elseif arg_7_1 == var_0_4.CRASH_STATE then
		self:changeToCrashState()
	end

	self._portalState = arg_7_1

	return
end

function ys.Battle.BattleFunnelUnit:AddCreateTimer(arg_8_1, arg_8_2)
	self._currentState = self.STATE_CREATE
	self._speedDir = arg_8_1
	self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(20)
	arg_8_2 = arg_8_2 or 1.5
	self.updatePatrol = self._updateCreate
	self._createTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AddCreateTimer", 0, arg_8_2, function()
		self._existStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(self._tmpData.speed)

		self:changePartolState(var_0_4.MOVE_STATE)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._createTimer)

		self._createTimer = nil

		return
	end)

	return
end

function ys.Battle.BattleFunnelUnit:updatePosition()
	self._pos = self._pos + self._speed

	return
end

function ys.Battle.BattleFunnelUnit:_updateCreate()
	self:UpdateSpeed()
	self:updatePosition()

	return
end

function ys.Battle.BattleFunnelUnit:nonWeaponStopState()
	self._stopStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	self.updatePatrol = self._updateStop

	return
end

function ys.Battle.BattleFunnelUnit:stopState()
	self._stopStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local var_13_0 = var_0_2.TargetHarmNearest(self)[1]
	local var_13_1 = self:GetWeapon()[1]

	var_13_1:updateMovementInfo()

	if var_13_0 == nil then
		self:changePartolState(var_0_4.CRASH_STATE)
	elseif var_13_1:IsOutOfFireArea(var_13_0) then
		self:changePartolState(var_0_4.MOVE_STATE)
	else
		self.updatePatrol = self._updateStop
	end

	return
end

function ys.Battle.BattleFunnelUnit:_updateStop(arg_14_1)
	if self:getStopDuration() < pg.TimeMgr.GetInstance():GetCombatTime() then
		self:changePartolState(var_0_4.MOVE_STATE)
	else
		self:UpdateWeapon()
	end

	return
end

function ys.Battle.BattleFunnelUnit:getStopDuration()
	return self._stopStartTime + self._stayDuration
end

function ys.Battle.BattleFunnelUnit:changeToMoveState()
	self:generateMoveTargetPoint()

	self.updatePatrol = self._updateMove

	return
end

function ys.Battle.BattleFunnelUnit:_updateMove(arg_17_1)
	self._speed = self._direction * self:GetSpeedRatio()

	self:updatePosition()

	if Vector3.Distance(self:GetPosition(), self._moveTargetPosition) < 1 then
		self:changePartolState(var_0_4.STOP_STATE)
	end

	return
end

function ys.Battle.BattleFunnelUnit:generateMoveTargetPoint()
	self._moveTargetPosition = Vector3(math.random(self._leftBound, self._rightBound), self:GetPosition().y, (math.random(self._upperBound, self._lowerBound)))
	;(self._moveTargetPosition - self._pos).normalized.y = 0

	;(self._moveTargetPosition - self._pos).normalized:Mul(self._velocity)

	self._direction = (self._moveTargetPosition - self._pos).normalized

	return
end

function ys.Battle.BattleFunnelUnit:changeToCrashState()
	self._existStartTime = nil

	if self:GetIFF() == var_0_1.FOE_CODE then
		self._speedDir = Vector3.left
	elseif self:GetIFF() == var_0_1.FRIENDLY_CODE then
		self._speedDir = Vector3.right
	end

	self.updatePatrol = self._updateCrash

	return
end

function ys.Battle.BattleFunnelUnit:_updateCrash()
	self:UpdateSpeed()
	self:updatePosition()

	return
end

return
