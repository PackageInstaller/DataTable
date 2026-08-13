ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleTargetChoise
local var_0_3 = var_0.Battle.BattleUnitEvent
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleFunnelUnit = var_0_10005("BattleFunnelUnit", var_0.Battle.BattleAircraftUnit)
var_0.Battle.BattleFunnelUnit.__name = "BattleFunnelUnit"

local var_0_5 = var_0.Battle.BattleFunnelUnit

var_0_5.STOP_STATE = "STOP_STATE"
var_0_5.MOVE_STATE = "MOVE_STATE"
var_0_5.CRASH_STATE = "CRASH_STATE"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	var_0_5.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._dir = var_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0.Battle.BattleConst.UnitType.FUNNEL_UNIT

	return
end

function var_0_5.Update(arg_2_0, arg_2_1)
	arg_2_0:updateExist()
	arg_2_0:updatePatrol(arg_2_1)

	return
end

function var_0_5.updateExist(arg_3_0)
	if not arg_3_0._existStartTime then
		return
	end

	local var_3_0 = arg_3_0._existStartTime + arg_3_0._existDuration

	pg = var_2

	local var_3_1 = var_2.TimeMgr.GetInstance()

	if var_3_0 < var_2.GetCombatTime(var_3_1) then
		arg_3_0:changePartolState(var_0_5.CRASH_STATE)
	end

	return
end

function var_0_5.UpdateWeapon(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0:GetWeapon()) do
		iter_4_1:Update()
	end

	return
end

function var_0_5.SetMotherUnit(arg_5_0, arg_5_1)
	var_0_5.super.SetMotherUnit(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_0:GetIFF() * -1
	local var_5_1 = var_0.Battle.BattleDataProxy.GetInstance()

	arg_5_0._upperBound, arg_5_0._lowerBound, arg_5_0._leftBound, arg_5_0._rightBound = var_3.GetFleetBoundByIFF(var_5_1, var_5_0)

	return
end

function var_0_5.SetTemplate(arg_6_0, arg_6_1)
	var_0_5.super.SetTemplate(arg_6_0, arg_6_1)

	arg_6_0._existDuration = arg_6_1.funnel_behavior.exist
	arg_6_0._stayDuration = arg_6_1.funnel_behavior.stay

	local var_6_0

	if not arg_6_1.funnel_behavior.front then
		var_6_0 = 0
	end

	arg_6_0._frontOffset = var_6_0

	local var_6_1

	if not arg_6_1.funnel_behavior.rear then
		var_6_1 = 0
	end

	arg_6_0._rearOffset = var_6_1

	if arg_6_0:GetWeapon()[1] then
		arg_6_0.changeToStopState = var_0_5.stopState
	else
		arg_6_0.changeToStopState = var_0_5.nonWeaponStopState
	end

	if arg_6_0:GetIFF() == var_0_1.FRIENDLY_CODE then
		arg_6_0._leftBound = arg_6_0._leftBound + arg_6_0._rearOffset
		arg_6_0._rightBound = arg_6_0._rightBound + arg_6_0._frontOffset
	else
		arg_6_0._leftBound = arg_6_0._leftBound - arg_6_0._frontOffset
		arg_6_0._rightBound = arg_6_0._rightBound - arg_6_0._rearOffset
	end

	return
end

function var_0_5.changePartolState(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_5.MOVE_STATE then
		arg_7_0:changeToMoveState()
	elseif arg_7_1 == var_0_5.STOP_STATE then
		arg_7_0:changeToStopState()
	elseif arg_7_1 == var_0_5.CRASH_STATE then
		arg_7_0:changeToCrashState()
	end

	arg_7_0._portalState = arg_7_1

	return
end

function var_0_5.AddCreateTimer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._currentState = arg_8_0.STATE_CREATE
	arg_8_0._speedDir = arg_8_1
	arg_8_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(20)
	arg_8_2 = arg_8_2 or 1.5

	local function var_8_0()
		local var_9_0 = arg_8_0

		pg = var_2_10001

		local var_9_1 = var_2_10001.TimeMgr.GetInstance()

		var_9_0._existStartTime = var_1.GetCombatTime(var_9_1)
		arg_8_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(arg_8_0._tmpData.speed)

		local var_9_2 = arg_8_0

		var_0.changePartolState(var_9_2, var_0_5.MOVE_STATE)

		pg = var_0

		local var_9_3 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_9_3, arg_8_0._createTimer)

		arg_8_0._createTimer = nil

		return
	end

	arg_8_0.updatePatrol = arg_8_0._updateCreate
	pg = var_4

	local var_8_1 = var_4.TimeMgr.GetInstance()

	arg_8_0._createTimer = var_4.AddBattleTimer(var_8_1, "AddCreateTimer", 0, arg_8_2, var_8_0)

	return
end

function var_0_5.updatePosition(arg_10_0)
	arg_10_0._pos = arg_10_0._pos + arg_10_0._speed

	return
end

function var_0_5._updateCreate(arg_11_0)
	arg_11_0:UpdateSpeed()
	arg_11_0:updatePosition()

	return
end

function var_0_5.nonWeaponStopState(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()

	arg_12_0._stopStartTime = var_1.GetCombatTime(var_12_0)
	arg_12_0.updatePatrol = arg_12_0._updateStop

	return
end

function var_0_5.stopState(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()

	arg_13_0._stopStartTime = var_1.GetCombatTime(var_13_0)

	local var_13_1 = var_0_2.TargetHarmNearest(arg_13_0)[1]
	local var_13_2 = arg_13_0:GetWeapon()[1]

	var_2.updateMovementInfo(var_13_2)

	if var_13_1 == nil then
		arg_13_0:changePartolState(var_0_5.CRASH_STATE)
	elseif var_2:IsOutOfFireArea(var_13_1) then
		arg_13_0:changePartolState(var_0_5.MOVE_STATE)
	else
		arg_13_0.updatePatrol = arg_13_0._updateStop
	end

	return
end

function var_0_5._updateStop(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getStopDuration()

	pg = var_1_10003

	local var_14_1 = var_1_10003.TimeMgr.GetInstance()

	if var_14_0 < var_3.GetCombatTime(var_14_1) then
		arg_14_0:changePartolState(var_0_5.MOVE_STATE)
	else
		arg_14_0:UpdateWeapon()
	end

	return
end

function var_0_5.getStopDuration(arg_15_0)
	return arg_15_0._stopStartTime + arg_15_0._stayDuration
end

function var_0_5.changeToMoveState(arg_16_0)
	arg_16_0:generateMoveTargetPoint()

	arg_16_0.updatePatrol = arg_16_0._updateMove

	return
end

function var_0_5._updateMove(arg_17_0, arg_17_1)
	arg_17_0._speed = arg_17_0._direction * arg_17_0:GetSpeedRatio()

	arg_17_0:updatePosition()

	Vector3 = var_2

	if var_2.Distance(arg_17_0:GetPosition(), arg_17_0._moveTargetPosition) < 1 then
		arg_17_0:changePartolState(var_0_5.STOP_STATE)
	end

	return
end

function var_0_5.generateMoveTargetPoint(arg_18_0)
	math = var_1_10001

	local var_18_0 = var_1_10001.random(arg_18_0._leftBound, arg_18_0._rightBound)

	math = var_1_10002

	local var_18_1 = var_1_10002.random(arg_18_0._upperBound, arg_18_0._lowerBound)

	Vector3 = var_3
	arg_18_0._moveTargetPosition = var_3(var_18_0, arg_18_0:GetPosition().y, var_18_1)

	local var_18_2 = (arg_18_0._moveTargetPosition - arg_18_0._pos).normalized

	var_18_2.y = 0

	var_18_2:Mul(arg_18_0._velocity)

	arg_18_0._direction = var_18_2

	return
end

function var_0_5.changeToCrashState(arg_19_0)
	arg_19_0._existStartTime = nil

	if arg_19_0:GetIFF() == var_0_1.FOE_CODE then
		Vector3 = var_1
		arg_19_0._speedDir = var_1.left
	elseif arg_19_0:GetIFF() == var_0_1.FRIENDLY_CODE then
		Vector3 = var_1
		arg_19_0._speedDir = var_1.right
	end

	arg_19_0.updatePatrol = arg_19_0._updateCrash

	return
end

function var_0_5._updateCrash(arg_20_0)
	arg_20_0:UpdateSpeed()
	arg_20_0:updatePosition()

	return
end

return
