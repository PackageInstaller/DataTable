ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleTargetChoise
local var_0_3 = var_0.Battle.BattleDataFunction
local var_0_4 = var_0.Battle.BattleUnitEvent
local var_0_5 = var_0.Battle

class = var_0_10006
var_0_5.BattlePatternFunnelUnit = var_0_10006("BattlePatternFunnelUnit", var_0.Battle.BattleAircraftUnit)
var_0.Battle.BattlePatternFunnelUnit.__name = "BattlePatternFunnelUnit"

local var_0_6 = var_0.Battle.BattlePatternFunnelUnit

var_0_6.STOP_STATE = "STOP_STATE"
var_0_6.MOVE_STATE = "MOVE_STATE"
var_0_6.CRASH_STATE = "CRASH_STATE"

function var_0_6.Ctor(arg_1_0, arg_1_1)
	var_0_6.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._untDir = var_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0.Battle.BattleConst.UnitType.FUNNEL_UNIT
	arg_1_0._move = var_0.Battle.MoveComponent.New()

	return
end

function var_0_6.Update(arg_2_0, arg_2_1)
	arg_2_0:updatePatrol(arg_2_1)
	arg_2_0:UpdateWeapon()
	arg_2_0:updatePosition()

	return
end

function var_0_6.OnMotherDead(arg_3_0)
	arg_3_0:onDead()

	return
end

function var_0_6.updateExist(arg_4_0)
	if not arg_4_0._existStartTime then
		return
	end

	local var_4_0 = arg_4_0._existStartTime + arg_4_0._existDuration

	pg = var_2

	local var_4_1 = var_2.TimeMgr.GetInstance()

	if var_4_0 < var_2.GetCombatTime(var_4_1) then
		arg_4_0:changePartolState(var_0_6.CRASH_STATE)
	end

	return
end

function var_0_6.UpdateWeapon(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0:GetWeapon()) do
		iter_5_1:Update()
	end

	return
end

function var_0_6.SetMotherUnit(arg_6_0, arg_6_1)
	var_0_6.super.SetMotherUnit(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_0:GetIFF() * -1
	local var_6_1 = var_0.Battle.BattleDataProxy.GetInstance()

	arg_6_0._upperBound, arg_6_0._lowerBound, arg_6_0._leftBound, arg_6_0._rightBound = var_3.GetFleetBoundByIFF(var_6_1, var_6_0)

	return
end

function var_0_6.SetTemplate(arg_7_0, arg_7_1)
	var_0_6.super.SetTemplate(arg_7_0, arg_7_1)

	arg_7_0._existDuration = arg_7_1.funnel_behavior.exist

	return
end

function var_0_6.changePartolState(arg_8_0, arg_8_1)
	if arg_8_1 == var_0_6.MOVE_STATE then
		arg_8_0:changeToMoveState()
	end

	arg_8_0._portalState = arg_8_1

	return
end

function var_0_6.AddCreateTimer(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._currentState = arg_9_0.STATE_CREATE
	arg_9_0._speedDir = arg_9_1
	arg_9_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(30)

	local function var_9_0()
		local var_10_0 = arg_9_0

		pg = var_2_10001

		local var_10_1 = var_2_10001.TimeMgr.GetInstance()

		var_10_0._existStartTime = var_1.GetCombatTime(var_10_1)
		arg_9_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(arg_9_0._tmpData.speed)

		local var_10_2 = arg_9_0

		var_0.changePartolState(var_10_2, var_0_6.MOVE_STATE)

		pg = var_0

		local var_10_3 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_10_3, arg_9_0._createTimer)

		arg_9_0._createTimer = nil

		return
	end

	arg_9_0.updatePatrol = arg_9_0._updateCreate
	pg = var_4

	local var_9_1 = var_4.TimeMgr.GetInstance()

	arg_9_0._createTimer = var_4.AddBattleTimer(var_9_1, "AddCreateTimer", 0, 0.5, var_9_0)

	return
end

function var_0_6.updatePosition(arg_11_0)
	arg_11_0._pos = arg_11_0._pos + arg_11_0._speed

	return
end

function var_0_6._updateCreate(arg_12_0)
	arg_12_0:UpdateSpeed()
	arg_12_0:updatePosition()

	return
end

function var_0_6.changeToMoveState(arg_13_0)
	arg_13_0._currentState = var_0_6.MOVE_STATE

	local var_13_0 = var_0_3.GetAITmpDataFromID(arg_13_0._tmpData.funnel_behavior.AI)
	local var_13_1 = var_0.Battle.AutoPilot.New(arg_13_0, var_13_0)
	local var_13_2 = arg_13_0._move

	var_3.ImmuneMaxAreaLimit(var_13_2, true)

	local var_13_3 = arg_13_0._move

	var_3.CancelFormationCtrl(var_13_3)

	arg_13_0._autoPilotAI = var_13_1

	local var_13_4 = arg_13_0._autoPilotAI

	var_3.SetHiveUnit(var_13_4, arg_13_0._motherUnit)

	arg_13_0.updatePatrol = arg_13_0._updateMove

	return
end

function var_0_6._updateMove(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._move

	var_2.Update(var_14_0)

	local var_14_1 = arg_14_0._speed
	local var_14_2 = var_2.Copy
	local var_14_3 = arg_14_0._move

	var_14_2(var_14_1, var_4.GetSpeed(var_14_3))

	local var_14_4 = arg_14_0._speed

	var_2.Mul(var_14_4, arg_14_0._velocity * arg_14_0:GetSpeedRatio())
	arg_14_0:updatePosition()

	return
end

return
