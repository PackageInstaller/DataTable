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

function ys.Battle.BattleFunnelUnit.Update(arg_2_0, arg_2_1)
	arg_2_0:updateExist()
	arg_2_0:updatePatrol(arg_2_1)

	return
end

function ys.Battle.BattleFunnelUnit.updateExist(arg_3_0)
	if not arg_3_0._existStartTime then
		return
	end

	if arg_3_0._existStartTime + arg_3_0._existDuration < pg.TimeMgr.GetInstance():GetCombatTime() then
		arg_3_0:changePartolState(var_0_4.CRASH_STATE)
	end

	return
end

function ys.Battle.BattleFunnelUnit.UpdateWeapon(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0:GetWeapon()) do
		iter_4_1:Update()
	end

	return
end

function ys.Battle.BattleFunnelUnit.SetMotherUnit(arg_5_0, arg_5_1)
	var_0_4.super.SetMotherUnit(arg_5_0, arg_5_1)

	arg_5_0._upperBound, arg_5_0._lowerBound, arg_5_0._leftBound, arg_5_0._rightBound = var_0_0.Battle.BattleDataProxy.GetInstance():GetFleetBoundByIFF(arg_5_0:GetIFF() * -1)

	return
end

function ys.Battle.BattleFunnelUnit.SetTemplate(arg_6_0, arg_6_1)
	var_0_4.super.SetTemplate(arg_6_0, arg_6_1)

	arg_6_0._existDuration = arg_6_1.funnel_behavior.exist
	arg_6_0._stayDuration = arg_6_1.funnel_behavior.stay
	arg_6_0._frontOffset = arg_6_1.funnel_behavior.front or 0
	arg_6_0._rearOffset = arg_6_1.funnel_behavior.rear or 0
	arg_6_0.changeToStopState = arg_6_0:GetWeapon()[1] and var_0_4.stopState or var_0_4.nonWeaponStopState

	if arg_6_0:GetIFF() == var_0_1.FRIENDLY_CODE then
		arg_6_0._leftBound = arg_6_0._leftBound + arg_6_0._rearOffset
		arg_6_0._rightBound = arg_6_0._rightBound + arg_6_0._frontOffset
	else
		arg_6_0._leftBound = arg_6_0._leftBound - arg_6_0._frontOffset
		arg_6_0._rightBound = arg_6_0._rightBound - arg_6_0._rearOffset
	end

	return
end

function ys.Battle.BattleFunnelUnit.changePartolState(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_4.MOVE_STATE then
		arg_7_0:changeToMoveState()
	elseif arg_7_1 == var_0_4.STOP_STATE then
		arg_7_0:changeToStopState()
	elseif arg_7_1 == var_0_4.CRASH_STATE then
		arg_7_0:changeToCrashState()
	end

	arg_7_0._portalState = arg_7_1

	return
end

function ys.Battle.BattleFunnelUnit.AddCreateTimer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._currentState = arg_8_0.STATE_CREATE
	arg_8_0._speedDir = arg_8_1
	arg_8_0._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(20)
	arg_8_2 = arg_8_2 or 1.5

	local function var_8_0()
		arg_8_0._existStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		arg_8_0._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(arg_8_0._tmpData.speed)

		arg_8_0:changePartolState(var_0_4.MOVE_STATE)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_8_0._createTimer)

		arg_8_0._createTimer = nil

		return
	end

	arg_8_0.updatePatrol = arg_8_0._updateCreate
	arg_8_0._createTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AddCreateTimer", 0, arg_8_2, var_8_0)

	return
end

function ys.Battle.BattleFunnelUnit.updatePosition(arg_10_0)
	arg_10_0._pos = arg_10_0._pos + arg_10_0._speed

	return
end

function ys.Battle.BattleFunnelUnit._updateCreate(arg_11_0)
	arg_11_0:UpdateSpeed()
	arg_11_0:updatePosition()

	return
end

function ys.Battle.BattleFunnelUnit.nonWeaponStopState(arg_12_0)
	arg_12_0._stopStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_12_0.updatePatrol = arg_12_0._updateStop

	return
end

function ys.Battle.BattleFunnelUnit.stopState(arg_13_0)
	arg_13_0._stopStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local var_13_0 = var_0_2.TargetHarmNearest(arg_13_0)[1]
	local var_13_1 = arg_13_0:GetWeapon()[1]

	var_13_1:updateMovementInfo()

	if var_13_0 == nil then
		arg_13_0:changePartolState(var_0_4.CRASH_STATE)
	elseif var_13_1:IsOutOfFireArea(var_13_0) then
		arg_13_0:changePartolState(var_0_4.MOVE_STATE)
	else
		arg_13_0.updatePatrol = arg_13_0._updateStop
	end

	return
end

function ys.Battle.BattleFunnelUnit._updateStop(arg_14_0, arg_14_1)
	if arg_14_0:getStopDuration() < pg.TimeMgr.GetInstance():GetCombatTime() then
		arg_14_0:changePartolState(var_0_4.MOVE_STATE)
	else
		arg_14_0:UpdateWeapon()
	end

	return
end

function ys.Battle.BattleFunnelUnit.getStopDuration(arg_15_0)
	return arg_15_0._stopStartTime + arg_15_0._stayDuration
end

function ys.Battle.BattleFunnelUnit.changeToMoveState(arg_16_0)
	arg_16_0:generateMoveTargetPoint()

	arg_16_0.updatePatrol = arg_16_0._updateMove

	return
end

function ys.Battle.BattleFunnelUnit._updateMove(arg_17_0, arg_17_1)
	arg_17_0._speed = arg_17_0._direction * arg_17_0:GetSpeedRatio()

	arg_17_0:updatePosition()

	if Vector3.Distance(arg_17_0:GetPosition(), arg_17_0._moveTargetPosition) < 1 then
		arg_17_0:changePartolState(var_0_4.STOP_STATE)
	end

	return
end

function ys.Battle.BattleFunnelUnit.generateMoveTargetPoint(arg_18_0)
	arg_18_0._moveTargetPosition = Vector3(math.random(arg_18_0._leftBound, arg_18_0._rightBound), arg_18_0:GetPosition().y, (math.random(arg_18_0._upperBound, arg_18_0._lowerBound)))
	;(arg_18_0._moveTargetPosition - arg_18_0._pos).normalized.y = 0

	;(arg_18_0._moveTargetPosition - arg_18_0._pos).normalized:Mul(arg_18_0._velocity)

	arg_18_0._direction = (arg_18_0._moveTargetPosition - arg_18_0._pos).normalized

	return
end

function ys.Battle.BattleFunnelUnit.changeToCrashState(arg_19_0)
	arg_19_0._existStartTime = nil

	if arg_19_0:GetIFF() == var_0_1.FOE_CODE then
		arg_19_0._speedDir = Vector3.left
	elseif arg_19_0:GetIFF() == var_0_1.FRIENDLY_CODE then
		arg_19_0._speedDir = Vector3.right
	end

	arg_19_0.updatePatrol = arg_19_0._updateCrash

	return
end

function ys.Battle.BattleFunnelUnit._updateCrash(arg_20_0)
	arg_20_0:UpdateSpeed()
	arg_20_0:updatePosition()

	return
end

return
