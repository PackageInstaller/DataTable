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

function ys.Battle.BattlePatternFunnelUnit.Update(arg_2_0, arg_2_1)
	arg_2_0:updatePatrol(arg_2_1)
	arg_2_0:UpdateWeapon()
	arg_2_0:updatePosition()

	return
end

function ys.Battle.BattlePatternFunnelUnit.OnMotherDead(arg_3_0)
	arg_3_0:onDead()

	return
end

function ys.Battle.BattlePatternFunnelUnit.updateExist(arg_4_0)
	if not arg_4_0._existStartTime then
		return
	end

	if arg_4_0._existStartTime + arg_4_0._existDuration < pg.TimeMgr.GetInstance():GetCombatTime() then
		arg_4_0:changePartolState(var_0_5.CRASH_STATE)
	end

	return
end

function ys.Battle.BattlePatternFunnelUnit.UpdateWeapon(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0:GetWeapon()) do
		iter_5_1:Update()
	end

	return
end

function ys.Battle.BattlePatternFunnelUnit.SetMotherUnit(arg_6_0, arg_6_1)
	var_0_5.super.SetMotherUnit(arg_6_0, arg_6_1)

	arg_6_0._upperBound, arg_6_0._lowerBound, arg_6_0._leftBound, arg_6_0._rightBound = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetBoundByIFF(arg_6_0:GetIFF() * -1)

	return
end

function ys.Battle.BattlePatternFunnelUnit.SetTemplate(arg_7_0, arg_7_1)
	var_0_5.super.SetTemplate(arg_7_0, arg_7_1)

	arg_7_0._existDuration = arg_7_1.funnel_behavior.exist

	return
end

function ys.Battle.BattlePatternFunnelUnit.changePartolState(arg_8_0, arg_8_1)
	if arg_8_1 == var_0_5.MOVE_STATE then
		arg_8_0:changeToMoveState()
	end

	arg_8_0._portalState = arg_8_1

	return
end

function ys.Battle.BattlePatternFunnelUnit.AddCreateTimer(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._currentState = arg_9_0.STATE_CREATE
	arg_9_0._speedDir = arg_9_1
	arg_9_0._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(30)
	arg_9_0.updatePatrol = arg_9_0._updateCreate
	arg_9_0._createTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AddCreateTimer", 0, 0.5, function()
		arg_9_0._existStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		arg_9_0._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(arg_9_0._tmpData.speed)

		arg_9_0:changePartolState(var_0_5.MOVE_STATE)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_9_0._createTimer)

		arg_9_0._createTimer = nil

		return
	end)

	return
end

function ys.Battle.BattlePatternFunnelUnit.updatePosition(arg_11_0)
	arg_11_0._pos = arg_11_0._pos + arg_11_0._speed

	return
end

function ys.Battle.BattlePatternFunnelUnit._updateCreate(arg_12_0)
	arg_12_0:UpdateSpeed()
	arg_12_0:updatePosition()

	return
end

function ys.Battle.BattlePatternFunnelUnit.changeToMoveState(arg_13_0)
	arg_13_0._currentState = var_0_5.MOVE_STATE

	arg_13_0._move:ImmuneMaxAreaLimit(true)
	arg_13_0._move:CancelFormationCtrl()

	arg_13_0._autoPilotAI = var_0_0.Battle.AutoPilot.New(arg_13_0, (var_0_3.GetAITmpDataFromID(arg_13_0._tmpData.funnel_behavior.AI)))

	arg_13_0._autoPilotAI:SetHiveUnit(arg_13_0._motherUnit)

	arg_13_0.updatePatrol = arg_13_0._updateMove

	return
end

function ys.Battle.BattlePatternFunnelUnit._updateMove(arg_14_0, arg_14_1)
	arg_14_0._move:Update()
	arg_14_0._speed:Copy(arg_14_0._move:GetSpeed())
	arg_14_0._speed:Mul(arg_14_0._velocity * arg_14_0:GetSpeedRatio())
	arg_14_0:updatePosition()

	return
end

return
