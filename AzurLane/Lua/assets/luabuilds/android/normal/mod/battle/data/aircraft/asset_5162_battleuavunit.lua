ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleTargetChoise
local var_0_3 = var_0.Battle.BattleUnitEvent
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattelUAVUnit = var_0_10005("BattelUAVUnit", var_0.Battle.BattleAircraftUnit)
var_0.Battle.BattelUAVUnit.__name = "BattelUAVUnit"

local var_0_5 = var_0.Battle.BattelUAVUnit

var_0_5.MOVE_STATE = "MOVE_STATE"
var_0_5.HOVER_STATE = "HOVER_STATE"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	var_0_5.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._dir = var_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0.Battle.BattleConst.UnitType.UAV_UNIT

	return
end

function var_0_5.Update(arg_2_0, arg_2_1)
	arg_2_0:updatePatrol(arg_2_1)

	return
end

function var_0_5.SetTemplate(arg_3_0, arg_3_1)
	var_0_5.super.SetTemplate(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_1.funnel_behavior.offsetX * arg_3_0:GetIFF()
	local var_3_1 = arg_3_1.funnel_behavior.offsetZ
	local var_3_2 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_3_3 = var_4.GetVanguardBornCoordinate(var_3_2, arg_3_0:GetIFF())

	BuildVector3 = var_3_2

	local var_3_4 = var_3_2(var_3_3)

	Vector3 = var_6
	arg_3_0._centerPos = var_3_4 + var_6(var_3_0, 0, var_3_1)
	arg_3_0._range = arg_3_1.funnel_behavior.hover_range

	return
end

function var_0_5.changePartolState(arg_4_0, arg_4_1)
	if arg_4_1 == var_0_5.MOVE_STATE then
		arg_4_0:changeToMoveState()
	elseif arg_4_1 == var_0_5.HOVER_STATE then
		arg_4_0:changeToHoverState()
	end

	arg_4_0._portalState = arg_4_1

	return
end

function var_0_5.AddCreateTimer(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._currentState = arg_5_0.STATE_CREATE
	arg_5_0._speedDir = arg_5_1
	arg_5_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(20)
	arg_5_2 = arg_5_2 or 1.5

	local function var_5_0()
		local var_6_0 = arg_5_0

		pg = var_2_10001

		local var_6_1 = var_2_10001.TimeMgr.GetInstance()

		var_6_0._existStartTime = var_1.GetCombatTime(var_6_1)
		arg_5_0._velocity = var_0.Battle.BattleFormulas.ConvertAircraftSpeed(arg_5_0._tmpData.speed)

		local var_6_2 = arg_5_0

		var_0.changePartolState(var_6_2, var_0_5.MOVE_STATE)

		pg = var_0

		local var_6_3 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_6_3, arg_5_0._createTimer)

		arg_5_0._createTimer = nil

		return
	end

	arg_5_0.updatePatrol = arg_5_0._updateCreate
	pg = var_4

	local var_5_1 = var_4.TimeMgr.GetInstance()

	arg_5_0._createTimer = var_4.AddBattleTimer(var_5_1, "AddCreateTimer", 0, arg_5_2, var_5_0)

	return
end

function var_0_5._updateCreate(arg_7_0)
	arg_7_0:UpdateSpeed()

	arg_7_0._pos = arg_7_0._pos + arg_7_0._speed

	return
end

function var_0_5.changeToMoveState(arg_8_0)
	arg_8_0._cruiseLimit = arg_8_0._centerPos.x
	arg_8_0.updatePatrol = arg_8_0._updateMove

	return
end

function var_0_5._updateMove(arg_9_0, arg_9_1)
	arg_9_0:UpdateSpeed()

	arg_9_0._pos = arg_9_0._pos + arg_9_0._speed

	if arg_9_0._IFF == var_0_1.FRIENDLY_CODE then
		if arg_9_0._pos.x > arg_9_0._cruiseLimit then
			arg_9_0:changePartolState(var_0_5.HOVER_STATE)
		end
	elseif arg_9_0._IFF == var_0_1.FOE_CODE and arg_9_0._pos.x < arg_9_0._cruiseLimit then
		arg_9_0:changePartolState(var_0_5.HOVER_STATE)
	end

	return
end

function var_0_5.changeToHoverState(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.TimeMgr.GetInstance()

	arg_10_0._hoverStartTime = var_1.GetCombatTime(var_10_0)
	arg_10_0.updatePatrol = arg_10_0._updateHover

	return
end

function var_0_5._updateHover(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 - arg_11_0._hoverStartTime

	Vector3 = var_1_10003
	math = var_1_10004

	local var_11_1 = var_1_10004.sin(var_11_0) * arg_11_0._range
	local var_11_2 = 15

	math = var_1_10006

	local var_11_3 = var_1_10003(var_11_1, var_11_2, var_1_10006.cos(var_11_0) * arg_11_0._range)

	arg_11_0._pos = var_3.Add(var_11_3, arg_11_0._centerPos)

	return
end

function var_0_5.GetSize(arg_12_0)
	if arg_12_0._portalState == var_0_5.HOVER_STATE then
		pg = var_1

		local var_12_0 = var_1.TimeMgr.GetInstance()
		local var_12_1 = var_1.GetCombatTime(var_12_0) - arg_12_0._hoverStartTime

		math = var_2

		local var_12_2

		if var_2.cos(var_12_1) > 0 and var_12_2 < 0.2 then
			var_12_2 = 0.2
		elseif var_12_2 <= 0 and var_12_2 > -0.2 then
			var_12_2 = -0.2
		end

		return var_12_2
	else
		var_0_5.super.GetSize(arg_12_0)
	end

	return
end

return
