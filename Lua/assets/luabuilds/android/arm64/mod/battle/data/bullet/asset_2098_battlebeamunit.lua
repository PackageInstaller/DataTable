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

function ys.Battle.BattleBeamUnit:IsBeamActive()
	return self._aoe:GetActiveFlag()
end

function ys.Battle.BattleBeamUnit.ClearBeam(arg_3_0)
	arg_3_0._beamState = var_0_3.BEAM_STATE_FINISH
	arg_3_0._aoe = nil
	arg_3_0._cldList = {}
	arg_3_0._nextDamageTime = nil

	return
end

function ys.Battle.BattleBeamUnit:SetAoeData(arg_4_1)
	self._aoe = arg_4_1
	self._beamTemp = var_0_0.GetBarrageTmpDataFromID(self._beamInfoID)
	self._bulletTemp = var_0_0.GetBulletTmpDataFromID(self._bulletID)
	self._angle = self._beamTemp.angle

	self._aoe:SetAngle(self._angle + self._aimAngle)

	if self._bulletTemp.extra_param.diveFilter then
		self._aoe:SetDiveFilter(self._bulletTemp.extra_param.diveFilter)
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

function ys.Battle.BattleBeamUnit:getAngleRatio()
	return var_0_1.GetSpeedRatio(self._aoe:GetTimeRationExemptKey(), self._aoe:GetIFF())
end

function ys.Battle.BattleBeamUnit:GetAoeData()
	return self._aoe
end

function ys.Battle.BattleBeamUnit:UpdateBeamPos(arg_9_1)
	self._aoe:SetPosition(Vector3(arg_9_1.x + self._beamTemp.offset_x, 0, arg_9_1.z + self._beamTemp.offset_z))

	return
end

function ys.Battle.BattleBeamUnit:UpdateBeamAngle()
	self._angle = self._angle + self._beamTemp.delta_angle * self:getAngleRatio()

	self._aoe:SetAngle(self._angle + self._aimAngle)

	return
end

function ys.Battle.BattleBeamUnit:AddCldUnit(arg_11_1)
	self._cldList[arg_11_1:GetUniqueID()] = arg_11_1

	return
end

function ys.Battle.BattleBeamUnit:RemoveCldUnit(arg_12_1)
	self._cldList[arg_12_1:GetUniqueID()] = nil

	return
end

function ys.Battle.BattleBeamUnit.ChangeBeamState(arg_13_0, arg_13_1)
	arg_13_0._beamState = arg_13_1

	return
end

function ys.Battle.BattleBeamUnit:GetBeamState()
	return self._beamState
end

function ys.Battle.BattleBeamUnit:GetCldUnitList()
	return self._cldList
end

function ys.Battle.BattleBeamUnit:BeginFocus()
	self._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._beamTemp.senior_delay

	return
end

function ys.Battle.BattleBeamUnit:DealDamage()
	self._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._beamTemp.delta_delay

	return
end

function ys.Battle.BattleBeamUnit:CanDealDamage()
	return self._nextDamageTime < pg.TimeMgr.GetInstance():GetCombatTime()
end

function ys.Battle.BattleBeamUnit:GetFXID()
	return self._bulletTemp.hit_fx
end

function ys.Battle.BattleBeamUnit:GetSFXID()
	return self._bulletTemp.hit_sfx
end

function ys.Battle.BattleBeamUnit:GetBulletID()
	return self._bulletID
end

function ys.Battle.BattleBeamUnit:GetBeamInfoID()
	return self._beamInfoID
end

function ys.Battle.BattleBeamUnit:GetBeamExtraParam()
	return self._bulletTemp.extra_param
end

return
