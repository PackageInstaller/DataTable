ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleVariable
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.BattleBeamUnit = class("BattleBeamUnit")
ys.Battle.BattleBeamUnit.__name = "BattleBeamUnit"

local var_0_3 = ys.Battle.BattleBeamUnit

ys.Battle.BattleBeamUnit.BEAM_STATE_READY = "ready"
ys.Battle.BattleBeamUnit.BEAM_STATE_ATTACK = "attack"
ys.Battle.BattleBeamUnit.BEAM_STATE_FINISH = "finish"

function ys.Battle.BattleBeamUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._bulletID = arg_1_1
	arg_1_0._beamInfoID = arg_1_2
	arg_1_0._cldList = {}
	arg_1_0._beamState = var_0_3.BEAM_STATE_READY

	return
end

function ys.Battle.BattleBeamUnit.IsBeamActive(arg_2_0)
	return arg_2_0._aoe:GetActiveFlag()
end

function ys.Battle.BattleBeamUnit.ClearBeam(arg_3_0)
	arg_3_0._beamState = var_0_3.BEAM_STATE_FINISH
	arg_3_0._aoe = nil
	arg_3_0._cldList = {}
	arg_3_0._nextDamageTime = nil

	return
end

function ys.Battle.BattleBeamUnit.SetAoeData(arg_4_0, arg_4_1)
	arg_4_0._aoe = arg_4_1
	arg_4_0._beamTemp = var_0_0.GetBarrageTmpDataFromID(arg_4_0._beamInfoID)
	arg_4_0._bulletTemp = var_0_0.GetBulletTmpDataFromID(arg_4_0._bulletID)
	arg_4_0._angle = arg_4_0._beamTemp.angle

	arg_4_0._aoe:SetAngle(arg_4_0._angle + arg_4_0._aimAngle)

	if arg_4_0._bulletTemp.extra_param.diveFilter then
		arg_4_0._aoe:SetDiveFilter(arg_4_0._bulletTemp.extra_param.diveFilter)
	end

	return
end

function ys.Battle.BattleBeamUnit.SetAimAngle(arg_5_0, arg_5_1)
	arg_5_0._aimAngle = arg_5_1 or 0

	return
end

function ys.Battle.BattleBeamUnit.SetAimPosition(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 == var_0_2.FOE_CODE then
		arg_6_0._aimAngle = math.rad2Deg * math.atan2(arg_6_2.z - arg_6_1.z, arg_6_2.x - arg_6_1.x)
	elseif arg_6_3 == var_0_2.FRIENDLY_CODE then
		arg_6_0._aimAngle = math.rad2Deg * math.atan2(arg_6_1.z - arg_6_2.z, arg_6_1.x - arg_6_2.x)
	end

	return
end

function ys.Battle.BattleBeamUnit.getAngleRatio(arg_7_0)
	return var_0_1.GetSpeedRatio(arg_7_0._aoe:GetTimeRationExemptKey(), arg_7_0._aoe:GetIFF())
end

function ys.Battle.BattleBeamUnit.GetAoeData(arg_8_0)
	return arg_8_0._aoe
end

function ys.Battle.BattleBeamUnit.UpdateBeamPos(arg_9_0, arg_9_1)
	arg_9_0._aoe:SetPosition(Vector3(arg_9_1.x + arg_9_0._beamTemp.offset_x, 0, arg_9_1.z + arg_9_0._beamTemp.offset_z))

	return
end

function ys.Battle.BattleBeamUnit.UpdateBeamAngle(arg_10_0)
	arg_10_0._angle = arg_10_0._angle + arg_10_0._beamTemp.delta_angle * arg_10_0:getAngleRatio()

	arg_10_0._aoe:SetAngle(arg_10_0._angle + arg_10_0._aimAngle)

	return
end

function ys.Battle.BattleBeamUnit.AddCldUnit(arg_11_0, arg_11_1)
	arg_11_0._cldList[arg_11_1:GetUniqueID()] = arg_11_1

	return
end

function ys.Battle.BattleBeamUnit.RemoveCldUnit(arg_12_0, arg_12_1)
	arg_12_0._cldList[arg_12_1:GetUniqueID()] = nil

	return
end

function ys.Battle.BattleBeamUnit.ChangeBeamState(arg_13_0, arg_13_1)
	arg_13_0._beamState = arg_13_1

	return
end

function ys.Battle.BattleBeamUnit.GetBeamState(arg_14_0)
	return arg_14_0._beamState
end

function ys.Battle.BattleBeamUnit.GetCldUnitList(arg_15_0)
	return arg_15_0._cldList
end

function ys.Battle.BattleBeamUnit.BeginFocus(arg_16_0)
	arg_16_0._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_16_0._beamTemp.senior_delay

	return
end

function ys.Battle.BattleBeamUnit.DealDamage(arg_17_0)
	arg_17_0._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_17_0._beamTemp.delta_delay

	return
end

function ys.Battle.BattleBeamUnit.CanDealDamage(arg_18_0)
	local var_18_0 = pg.TimeMgr.GetInstance()

	return arg_18_0._nextDamageTime < var_18_0:GetCombatTime()
end

function ys.Battle.BattleBeamUnit.GetFXID(arg_19_0)
	return arg_19_0._bulletTemp.hit_fx
end

function ys.Battle.BattleBeamUnit.GetSFXID(arg_20_0)
	return arg_20_0._bulletTemp.hit_sfx
end

function ys.Battle.BattleBeamUnit.GetBulletID(arg_21_0)
	return arg_21_0._bulletID
end

function ys.Battle.BattleBeamUnit.GetBeamInfoID(arg_22_0)
	return arg_22_0._beamInfoID
end

function ys.Battle.BattleBeamUnit.GetBeamExtraParam(arg_23_0)
	return arg_23_0._bulletTemp.extra_param
end

return
