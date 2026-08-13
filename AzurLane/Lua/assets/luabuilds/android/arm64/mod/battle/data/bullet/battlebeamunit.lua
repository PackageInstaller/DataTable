ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle.BattleConfig
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.BattleBeamUnit = var_0_10005("BattleBeamUnit")
var_0.Battle.BattleBeamUnit.__name = "BattleBeamUnit"

local var_0_5 = var_0.Battle.BattleBeamUnit

var_0_5.BEAM_STATE_READY = "ready"
var_0_5.BEAM_STATE_ATTACK = "attack"
var_0_5.BEAM_STATE_FINISH = "finish"

function var_0_5.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._bulletID = arg_1_1
	arg_1_0._beamInfoID = arg_1_2
	arg_1_0._cldList = {}
	arg_1_0._beamState = var_0_5.BEAM_STATE_READY

	return
end

function var_0_5.IsBeamActive(arg_2_0)
	local var_2_0 = arg_2_0._aoe

	return var_1.GetActiveFlag(var_2_0)
end

function var_0_5.ClearBeam(arg_3_0)
	arg_3_0._beamState = var_0_5.BEAM_STATE_FINISH
	arg_3_0._aoe = nil
	arg_3_0._cldList = {}
	arg_3_0._nextDamageTime = nil

	return
end

function var_0_5.SetAoeData(arg_4_0, arg_4_1)
	arg_4_0._aoe = arg_4_1
	arg_4_0._beamTemp = var_0_1.GetBarrageTmpDataFromID(arg_4_0._beamInfoID)
	arg_4_0._bulletTemp = var_0_1.GetBulletTmpDataFromID(arg_4_0._bulletID)
	arg_4_0._angle = arg_4_0._beamTemp.angle

	local var_4_0 = arg_4_0._aoe

	var_2.SetAngle(var_4_0, arg_4_0._angle + arg_4_0._aimAngle)

	if arg_4_0._bulletTemp.extra_param.diveFilter then
		local var_4_1 = arg_4_0._aoe

		var_3.SetDiveFilter(var_4_1, var_2)
	end

	return
end

function var_0_5.SetAimAngle(arg_5_0, arg_5_1)
	arg_5_0._aimAngle = arg_5_1 or 0

	return
end

function var_0_5.SetAimPosition(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 == var_0_3.FOE_CODE then
		math = var_4

		local var_6_0 = var_4.rad2Deg

		math = var_1_10005
		arg_6_0._aimAngle = var_6_0 * var_1_10005.atan2(arg_6_2.z - arg_6_1.z, arg_6_2.x - arg_6_1.x)
	elseif arg_6_3 == var_0_3.FRIENDLY_CODE then
		math = var_4

		local var_6_1 = var_4.rad2Deg

		math = var_1_10005
		arg_6_0._aimAngle = var_6_1 * var_1_10005.atan2(arg_6_1.z - arg_6_2.z, arg_6_1.x - arg_6_2.x)
	end

	return
end

function var_0_5.getAngleRatio(arg_7_0)
	local var_7_0 = var_0_2.GetSpeedRatio
	local var_7_1 = arg_7_0._aoe
	local var_7_2 = var_3.GetTimeRationExemptKey(var_7_1)
	local var_7_3 = arg_7_0._aoe

	return var_7_0(var_7_2, var_4.GetIFF(var_7_3))
end

function var_0_5.GetAoeData(arg_8_0)
	return arg_8_0._aoe
end

function var_0_5.UpdateBeamPos(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._aoe
	local var_9_1 = var_2.SetPosition

	Vector3 = var_1_10005

	var_9_1(var_9_0, var_1_10005(arg_9_1.x + arg_9_0._beamTemp.offset_x, 0, arg_9_1.z + arg_9_0._beamTemp.offset_z))

	return
end

function var_0_5.UpdateBeamAngle(arg_10_0)
	arg_10_0._angle = arg_10_0._angle + arg_10_0._beamTemp.delta_angle * arg_10_0:getAngleRatio()

	local var_10_0 = arg_10_0._aoe

	var_1.SetAngle(var_10_0, arg_10_0._angle + arg_10_0._aimAngle)

	return
end

function var_0_5.AddCldUnit(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetUniqueID()

	arg_11_0._cldList[var_11_0] = arg_11_1

	return
end

function var_0_5.RemoveCldUnit(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:GetUniqueID()

	arg_12_0._cldList[var_12_0] = nil

	return
end

function var_0_5.ChangeBeamState(arg_13_0, arg_13_1)
	arg_13_0._beamState = arg_13_1

	return
end

function var_0_5.GetBeamState(arg_14_0)
	return arg_14_0._beamState
end

function var_0_5.GetCldUnitList(arg_15_0)
	return arg_15_0._cldList
end

function var_0_5.BeginFocus(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.TimeMgr.GetInstance()

	arg_16_0._nextDamageTime = var_1.GetCombatTime(var_16_0) + arg_16_0._beamTemp.senior_delay

	return
end

function var_0_5.DealDamage(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.TimeMgr.GetInstance()

	arg_17_0._nextDamageTime = var_1.GetCombatTime(var_17_0) + arg_17_0._beamTemp.delta_delay

	return
end

function var_0_5.CanDealDamage(arg_18_0)
	local var_18_0 = arg_18_0._nextDamageTime

	pg = var_1_10002

	local var_18_1 = var_1_10002.TimeMgr.GetInstance()

	return var_18_0 < var_2.GetCombatTime(var_18_1)
end

function var_0_5.GetFXID(arg_19_0)
	return arg_19_0._bulletTemp.hit_fx
end

function var_0_5.GetSFXID(arg_20_0)
	return arg_20_0._bulletTemp.hit_sfx
end

function var_0_5.GetBulletID(arg_21_0)
	return arg_21_0._bulletID
end

function var_0_5.GetBeamInfoID(arg_22_0)
	return arg_22_0._beamInfoID
end

function var_0_5.GetBeamExtraParam(arg_23_0)
	return arg_23_0._bulletTemp.extra_param
end

return
