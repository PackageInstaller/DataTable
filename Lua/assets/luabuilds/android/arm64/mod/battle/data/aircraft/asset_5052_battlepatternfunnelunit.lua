ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattleDataFunction

ys.Battle.BattlePatternFunnelUnit = class("BattlePatternFunnelUnit", ys.Battle.BattleAircraftUnit)
ys.Battle.BattlePatternFunnelUnit.__name = "BattlePatternFunnelUnit"

local var_0_5 = ys.Battle.BattlePatternFunnelUnit

ys.Battle.BattlePatternFunnelUnit.STOP_STATE = "STOP_STATE"
ys.Battle.BattlePatternFunnelUnit.MOVE_STATE = "MOVE_STATE"
ys.Battle.BattlePatternFunnelUnit.CRASH_STATE = "CRASH_STATE"

function ys.Battle.BattlePatternFunnelUnit.Ctor(arg_1_0, arg_1_1)
	var_0_5.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._untDir = var_0_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0_0.Battle.BattleConst.UnitType.FUNNEL_UNIT
	arg_1_0._move = var_0_0.Battle.MoveComponent.New()

	return
end

function ys.Battle.BattlePatternFunnelUnit:Update(arg_2_1)
	self:updatePatrol(arg_2_1)
	self:UpdateWeapon()
	self:updatePosition()

	return
end

function ys.Battle.BattlePatternFunnelUnit:OnMotherDead()
	self:onDead()

	return
end

function ys.Battle.BattlePatternFunnelUnit:updateExist()
	if not self._existStartTime then
		return
	end

	if self._existStartTime + self._existDuration < pg.TimeMgr.GetInstance():GetCombatTime() then
		self:changePartolState(var_0_5.CRASH_STATE)
	end

	return
end

function ys.Battle.BattlePatternFunnelUnit:UpdateWeapon()
	for iter_5_0, iter_5_1 in ipairs(self:GetWeapon()) do
		iter_5_1:Update()
	end

	return
end

function ys.Battle.BattlePatternFunnelUnit:SetMotherUnit(arg_6_1)
	var_0_5.super.SetMotherUnit(self, arg_6_1)

	self._upperBound, self._lowerBound, self._leftBound, self._rightBound = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetBoundByIFF(self:GetIFF() * -1)

	return
end

function ys.Battle.BattlePatternFunnelUnit.SetTemplate(arg_7_0, arg_7_1)
	var_0_5.super.SetTemplate(arg_7_0, arg_7_1)

	arg_7_0._existDuration = arg_7_1.funnel_behavior.exist

	return
end

function ys.Battle.BattlePatternFunnelUnit:changePartolState(arg_8_1)
	if arg_8_1 == var_0_5.MOVE_STATE then
		self:changeToMoveState()
	end

	self._portalState = arg_8_1

	return
end

function ys.Battle.BattlePatternFunnelUnit:AddCreateTimer(arg_9_1, arg_9_2)
	self._currentState = self.STATE_CREATE
	self._speedDir = arg_9_1
	self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(30)
	self.updatePatrol = self._updateCreate
	self._createTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AddCreateTimer", 0, 0.5, function()
		self._existStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(self._tmpData.speed)

		self:changePartolState(var_0_5.MOVE_STATE)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._createTimer)

		self._createTimer = nil

		return
	end)

	return
end

function ys.Battle.BattlePatternFunnelUnit:updatePosition()
	self._pos = self._pos + self._speed

	return
end

function ys.Battle.BattlePatternFunnelUnit:_updateCreate()
	self:UpdateSpeed()
	self:updatePosition()

	return
end

function ys.Battle.BattlePatternFunnelUnit:changeToMoveState()
	self._currentState = var_0_5.MOVE_STATE

	self._move:ImmuneMaxAreaLimit(true)
	self._move:CancelFormationCtrl()

	self._autoPilotAI = var_0_0.Battle.AutoPilot.New(self, (var_0_3.GetAITmpDataFromID(self._tmpData.funnel_behavior.AI)))

	self._autoPilotAI:SetHiveUnit(self._motherUnit)

	self.updatePatrol = self._updateMove

	return
end

function ys.Battle.BattlePatternFunnelUnit:_updateMove(arg_14_1)
	self._move:Update()
	self._speed:Copy(self._move:GetSpeed())
	self._speed:Mul(self._velocity * self:GetSpeedRatio())
	self:updatePosition()

	return
end

return
