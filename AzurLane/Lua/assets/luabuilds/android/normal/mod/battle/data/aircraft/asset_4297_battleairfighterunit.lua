ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleAirFighterUnit = var_0_10004("BattleAirFighterUnit", var_0.Battle.BattleAircraftUnit)
var_0.Battle.BattleAirFighterUnit.__name = "BattleAirFighterUnit"

local var_0_4 = var_0.Battle.BattleAirFighterUnit

Vector3 = var_4
Screen = var_5

local var_0_5 = var_5.width * -0.5

Screen = var_6
var_0_4.AIRFIGHTER_ENTER_POINT = var_4(var_0_5, var_6.height * 0.5, 15)
Vector3 = var_4
var_0_4.SPEED_FLY = var_4(3, 0, 0)
var_0_4.BACK_X = 100
var_0_4.DOWN_X = 30
var_0_4.ATTACK_X = -23
var_0_4.UP_X = -70
var_0_4.FREE_X = -75
var_0_4.HEIGHT = var_0.Battle.BattleConfig.AirFighterHeight
var_0_4.STRIKE_STATE_FLY = 0
var_0_4.STRIKE_STATE_BACK = 1
var_0_4.STRIKE_STATE_DOWN = 2
var_0_4.STRIKE_STATE_ATTACK = 3
var_0_4.STRIKE_STATE_UP = 4
var_0_4.STRIKE_STATE_FREE = 5
var_0_4.STRIKE_STATE_BACKWARD = 6
var_0_4.STRIKE_STATE_RECYCLE = 7

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._dir = var_0.Battle.BattleConst.UnitDir.LEFT
	arg_1_0._type = var_0.Battle.BattleConst.UnitType.AIRFIGHTER_UNIT

	arg_1_0:changeState(var_0_4.STRIKE_STATE_FLY)
	arg_1_0:calcYShakeMin()
	arg_1_0:calcYShakeMax()

	Vector3 = var_2
	arg_1_0._speedDir = var_2(1, 0, 0)
	arg_1_0._backwardWeaponID = {}

	return
end

function var_0_4.Update(arg_2_0, arg_2_1)
	arg_2_0:UpdateSpeed()
	arg_2_0:updateStrike()

	return
end

function var_0_4.UpdateWeapon(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0:GetWeapon()) do
		local var_3_0 = iter_3_1
		local var_3_1 = iter_3_1.GetWeaponId(var_3_0)

		table = var_3_0

		local var_3_2 = var_3_0.contains(arg_3_0._backwardWeaponID, var_3_1)
		local var_3_3 = iter_3_1:GetCurrentState()

		iter_3_1:Update()

		local var_3_4 = iter_3_1:GetCurrentState()

		if var_3_2 and var_3_3 == iter_3_1.STATE_READY and (var_3_4 == iter_3_1.STATE_ATTACK or var_3_4 == iter_3_1.STATE_OVER_HEAT) then
			arg_3_0:changeState(var_0_4.STRIKE_STATE_BACKWARD)
		end
	end

	return
end

function var_0_4.CreateWeapon(arg_4_0)
	local var_4_0 = {}

	type = var_1_10002

	if var_1_10002(arg_4_0._weaponTemplateID) == "table" then
		ipairs = var_2

		for iter_4_0, iter_4_1 in var_2(arg_4_0._weaponTemplateID) do
			var_4_0[iter_4_0] = var_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(iter_4_1, arg_4_0, iter_4_0)
		end
	else
		var_4_0[1] = var_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(arg_4_0._weaponTemplateID, arg_4_0, 1)
	end

	if arg_4_0._backwardWeaponID then
		ipairs = var_2

		for iter_4_2, iter_4_3 in var_2(arg_4_0._backwardWeaponID) do
			var_4_0[iter_4_2] = var_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(iter_4_3, arg_4_0, iter_4_2)
		end
	end

	return var_4_0
end

function var_0_4.SetWeaponTemplateID(arg_5_0, arg_5_1)
	arg_5_0._weaponTemplateID = arg_5_1

	return
end

function var_0_4.SetBackwardWeaponID(arg_6_0, arg_6_1)
	arg_6_0._backwardWeaponID = arg_6_1

	return
end

function var_0_4.SetTemplate(arg_7_0, arg_7_1)
	arg_7_0:SetAttr(arg_7_1)
	var_0_4.super.SetTemplate(arg_7_0, arg_7_1)

	return
end

function var_0_4.SetAttr(arg_8_0, arg_8_1)
	var_0.Battle.BattleAttr.SetAirFighterAttr(arg_8_0, arg_8_1)
	arg_8_0:SetIFF(-1)

	return
end

function var_0_4.UpdateSpeed(arg_9_0)
	local var_9_0 = arg_9_0._speed

	var_1.Copy(var_9_0, arg_9_0._speedDir)

	local var_9_1 = arg_9_0._speed

	var_1.Mul(var_9_1, arg_9_0._velocity * arg_9_0:GetSpeedRatio())

	return
end

function var_0_4.Free(arg_10_0)
	arg_10_0._undefeated = true

	arg_10_0:LiveCallBack()

	arg_10_0._aliveState = false

	return
end

function var_0_4.recycle(arg_11_0)
	arg_11_0:LiveCallBack()

	arg_11_0._aliveState = false

	return
end

function var_0_4.onDead(arg_12_0)
	arg_12_0._currentState = arg_12_0.STATE_DESTORY

	arg_12_0:DeadCallBack()

	arg_12_0._aliveState = false

	return
end

function var_0_4.GetPosition(arg_13_0)
	return arg_13_0._viewPos
end

function var_0_4.SetFormationIndex(arg_14_0, arg_14_1)
	arg_14_0._formationIndex = arg_14_1
	arg_14_0._flyStateScale = 12 / (arg_14_1 + 3) + 1

	arg_14_0:DispatchStrikeStateChange()

	return
end

function var_0_4.GetFormationIndex(arg_15_0)
	return arg_15_0._formationIndex
end

function var_0_4.SetFormationOffset(arg_16_0, arg_16_1)
	Vector3 = var_1_10002
	arg_16_0._formationOffset = var_1_10002(arg_16_1.x, arg_16_1.y, arg_16_1.z)
	Vector3 = var_2
	arg_16_0._formationOffsetOppo = var_2(arg_16_1.x * -1, arg_16_1.y, arg_16_1.z)

	return
end

function var_0_4.SetDeadCallBack(arg_17_0, arg_17_1)
	arg_17_0._deadCallBack = arg_17_1

	return
end

function var_0_4.DeadCallBack(arg_18_0)
	arg_18_0._deadCallBack()

	return
end

function var_0_4.SetLiveCallBack(arg_19_0, arg_19_1)
	arg_19_0._liveCallBack = arg_19_1

	return
end

function var_0_4.LiveCallBack(arg_20_0)
	arg_20_0._liveCallBack()

	return
end

function var_0_4.getYShake(arg_21_0)
	local var_21_0

	if not arg_21_0._YShakeCurrent then
		var_21_0 = 0
	end

	local var_21_1

	if not arg_21_0._YShakeDir then
		var_21_1 = 1
	end

	arg_21_0._YShakeDir = var_21_1
	math = var_21_1

	if var_21_0 + (0.04 * var_21_1.random() + 0.01) * arg_21_0._YShakeDir > arg_21_0._YShakeMax then
		arg_21_0._YShakeDir = -1

		arg_21_0:calcYShakeMin()
	elseif var_1 < arg_21_0._YShakeMin then
		arg_21_0._YShakeDir = 1

		arg_21_0:calcYShakeMax()
	end

	arg_21_0._YShakeCurrent = var_1

	return var_1
end

function var_0_4.calcYShakeMin(arg_22_0)
	math = var_1_10001
	arg_22_0._YShakeMin = -0.5 - var_1_10001.random()

	return
end

function var_0_4.calcYShakeMax(arg_23_0)
	math = var_1_10001
	arg_23_0._YShakeMax = 0.5 + var_1_10001.random()

	return
end

function var_0_4.DispatchStrikeStateChange(arg_24_0)
	arg_24_0:DispatchEvent(var_0.Event.New(var_0_2.AIR_STRIKE_STATE_CHANGE, {}))

	return
end

function var_0_4.GetStrikeState(arg_25_0)
	return arg_25_0._strikeState
end

function var_0_4.GetSize(arg_26_0)
	return arg_26_0._scale
end

function var_0_4.changeState(arg_27_0, arg_27_1)
	if arg_27_0._strikeState == arg_27_1 then
		return
	end

	arg_27_0._strikeState = arg_27_1

	if arg_27_1 == var_0_4.STRIKE_STATE_FLY then
		arg_27_0:changeToFlyState()

		arg_27_0.updateStrike = var_0_4._updatePosFly
	elseif arg_27_1 == var_0_4.STRIKE_STATE_BACK then
		arg_27_0.updateStrike = var_0_4._updatePosBack

		arg_27_0:changeToBackState()
	elseif arg_27_1 == var_0_4.STRIKE_STATE_DOWN then
		arg_27_0.updateStrike = var_0_4._updatePosDown

		arg_27_0:changeToDownState()
	elseif arg_27_1 == var_0_4.STRIKE_STATE_ATTACK then
		arg_27_0.updateStrike = var_0_4._updatePosAttack

		arg_27_0:changeToAttackState()
	elseif arg_27_1 == var_0_4.STRIKE_STATE_UP then
		arg_27_0.updateStrike = var_0_4._updatePosUp

		arg_27_0:changeToUpState()
	elseif arg_27_1 == var_0_4.STRIKE_STATE_BACKWARD then
		arg_27_0.updateStrike = var_0_4._updateBackward

		arg_27_0:changeToBackwardState()
	elseif arg_27_1 == var_0_4.STRIKE_STATE_FREE then
		arg_27_0.updateStrike = var_0_4._updateFree
	elseif arg_27_1 == var_0_4.STRIKE_STATE_RECYCLE then
		arg_27_0.updateStrike = var_0_4._updateRecycle
	end

	arg_27_0:DispatchStrikeStateChange()

	return
end

function var_0_4.changeToFlyState(arg_28_0)
	local var_28_0 = var_0.Battle.BattleCameraUtil.GetInstance()

	arg_28_0._pos = var_1.GetS2WPoint(var_28_0, var_0_4.AIRFIGHTER_ENTER_POINT)
	arg_28_0._viewPos = arg_28_0._pos

	var_0.Battle.PlayBattleSFX("battle/plane")

	return
end

function var_0_4._updatePosFly(arg_29_0)
	local var_29_0 = arg_29_0._pos

	var_1.Add(var_29_0, var_0_4.SPEED_FLY)

	Vector3 = var_1

	local var_29_1 = var_1(arg_29_0._formationOffset.x * arg_29_0._flyStateScale, (arg_29_0._formationOffset.z / 1.7 + arg_29_0:getYShake()) * arg_29_0._flyStateScale, 0)

	arg_29_0._viewPos = var_1.Add(var_29_1, arg_29_0._pos)

	if arg_29_0._pos.x > var_0_4.BACK_X then
		arg_29_0:changeState(var_0_4.STRIKE_STATE_BACK)
	end

	return
end

function var_0_4.changeToBackState(arg_30_0)
	local var_30_0
	local var_30_1 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_30_2 = var_2.GetFleetByIFF(var_30_1, var_0_1.FRIENDLY_CODE)

	if var_2.GetMotion(var_30_2) then
		var_30_0 = var_2:GetPos().z
	else
		var_30_0 = 45
	end

	Vector3 = var_30_2
	arg_30_0._pos = var_30_2(arg_30_0._pos.x, 15, var_30_0)

	return
end

function var_0_4._updatePosBack(arg_31_0)
	local var_31_0 = arg_31_0._pos

	var_1.Sub(var_31_0, arg_31_0._speed)

	local var_31_1 = arg_31_0._viewPos

	var_1.Copy(var_31_1, arg_31_0._pos)

	local var_31_2 = arg_31_0._viewPos

	var_1.Sub(var_31_2, arg_31_0._formationOffset)

	if arg_31_0._pos.x < var_0_4.DOWN_X then
		arg_31_0:changeState(var_0_4.STRIKE_STATE_DOWN)
	end

	return
end

function var_0_4.changeToDownState(arg_32_0)
	arg_32_0._ySpeed = 0.5

	arg_32_0:SetVisitable()

	return
end

function var_0_4._updatePosDown(arg_33_0)
	local var_33_0 = arg_33_0._pos

	var_1.Sub(var_33_0, arg_33_0._speed)

	local var_33_1 = arg_33_0._pos

	math = var_33_0
	var_33_1.y = var_33_0.max(var_0_4.HEIGHT, arg_33_0._pos.y - arg_33_0._ySpeed)
	arg_33_0._viewPos = arg_33_0._pos + arg_33_0._formationOffsetOppo
	math = var_1
	arg_33_0._ySpeed = var_1.max(0.02, arg_33_0._ySpeed - 0.005)

	if arg_33_0._pos.x < var_0_4.ATTACK_X then
		arg_33_0:changeState(var_0_4.STRIKE_STATE_ATTACK)
	end

	return
end

function var_0_4.changeToAttackState(arg_34_0)
	var_0.Battle.PlayBattleSFX("battle/air-atk")

	return
end

function var_0_4._updatePosAttack(arg_35_0)
	local var_35_0 = arg_35_0._pos

	var_1.Sub(var_35_0, arg_35_0._speed)

	local var_35_1 = arg_35_0._pos

	math = var_35_0
	var_35_1.y = var_35_0.max(var_0_4.HEIGHT, arg_35_0._pos.y - 0.04)

	local var_35_2 = arg_35_0._formationOffsetOppo

	var_35_2.y = arg_35_0:getYShake()
	arg_35_0._viewPos = arg_35_0._pos + var_35_2

	arg_35_0:UpdateWeapon()

	if arg_35_0._pos.x < var_0_4.UP_X then
		arg_35_0:changeState(var_0_4.STRIKE_STATE_UP)
	end

	return
end

function var_0_4.changeToUpState(arg_36_0)
	arg_36_0._ySpeed = 0.1

	return
end

function var_0_4._updatePosUp(arg_37_0)
	local var_37_0 = arg_37_0._pos

	var_1.Sub(var_37_0, arg_37_0._speed)

	local var_37_1 = arg_37_0._pos

	var_37_1.y = arg_37_0._pos.y + arg_37_0._ySpeed
	math = var_37_1
	arg_37_0._ySpeed = var_37_1.min(0.7, arg_37_0._ySpeed + 0.02)
	arg_37_0._viewPos = arg_37_0._pos + arg_37_0._formationOffsetOppo

	if arg_37_0._pos.x < var_0_4.FREE_X then
		arg_37_0:changeState(var_0_4.STRIKE_STATE_FREE)
	end

	return
end

function var_0_4._updateFree(arg_38_0)
	arg_38_0:Free()

	return
end

function var_0_4.changeToBackwardState(arg_39_0)
	return
end

function var_0_4._updateBackward(arg_40_0)
	local var_40_0 = arg_40_0._pos

	var_1.Add(var_40_0, arg_40_0._speed)

	local var_40_1 = arg_40_0._pos

	math = var_40_0
	var_40_1.y = var_40_0.max(var_0_4.HEIGHT, arg_40_0._pos.y - 0.04)
	arg_40_0._viewPos = arg_40_0._pos + arg_40_0._formationOffsetOppo

	if arg_40_0._pos.x > var_0_4.DOWN_X then
		arg_40_0:changeState(var_0_4.STRIKE_STATE_RECYCLE)
	end

	return
end

function var_0_4._updateRecycle(arg_41_0)
	arg_41_0:recycle()

	return
end

return
