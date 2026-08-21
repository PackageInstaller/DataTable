require("skill_phase_param_base")
local SkillPhaseParam_TrajectoryType = {
  Line = 1,
  Parabola = 2,
  Laser = 3
}
_enum("SkillPhaseParam_TrajectoryType", SkillPhaseParam_TrajectoryType)
local SkillPhaseParam_PointType = {
  UserParam = 0,
  CasterPos = 1,
  CasterX = 2,
  CasterY = 3,
  TargetPos = 11,
  TargetX = 12,
  TargetY = 13
}
_enum("SkillPhaseParam_PointType", SkillPhaseParam_PointType)
_class("SkillPhaseParam_Trajectory", SkillPhaseParamBase)
SkillPhaseParam_Trajectory = SkillPhaseParam_Trajectory

function SkillPhaseParam_Trajectory:Constructor(t)
  self._trajectoryType = t.trajectoryType
  self._trajectoryEffectID = t.trajectoryEffectID
  self._trajectoryEffectOffset = t.trajectoryEffectOffset
  self._trajectoryTime = t.trajectoryTime
  self._totalTime = t.totalTime
  self._casterType = t.casterType
  self._casterParam = t.casterParam
  self._targetType = t.targetType
  self._targetParam = t.targetParam
  self._targetWaitTime = t.targetWaitTime
  self._targetEffectID = t.targetEffectID
  self._targetDelayTime = t.targetDelayTime or 0
  self._hitAnimationName = t.hitAnimationName
  self._hitEffectID = t.hitEffectID
  self._hitEffectTime = t.hitEffectTime
  self._clearBodyNow = t.clearBodyNow
  self._damageIndex = t.damageIndex or 1
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseParam_Trajectory:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._trajectoryEffectID)
  self:AddEffectIDToListID(listID, self._targetEffectID)
  self:AddEffectIDToListID(listID, self._hitEffectID)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseParam_Trajectory:GetPhaseType()
  return SkillViewPhaseType.Trajectory
end

function SkillPhaseParam_Trajectory:GetTrajectoryType()
  return self._trajectoryType
end

function SkillPhaseParam_Trajectory:GetTrajectoryEffectID()
  return self._trajectoryEffectID
end

function SkillPhaseParam_Trajectory:GetTrajectoryEffectOffset()
  return self._trajectoryEffectOffset
end

function SkillPhaseParam_Trajectory:GetTrajectoryTime()
  return self._trajectoryTime
end

function SkillPhaseParam_Trajectory:GetTotalTime()
  return self._totalTime
end

function SkillPhaseParam_Trajectory:GetCasterType()
  return self._casterType
end

function SkillPhaseParam_Trajectory:GetCasterParam()
  return self._casterParam
end

function SkillPhaseParam_Trajectory:GetTargetType()
  return self._targetType
end

function SkillPhaseParam_Trajectory:GetTargetParam()
  return self._targetParam
end

function SkillPhaseParam_Trajectory:GetTargetWaitTime()
  return self._targetWaitTime
end

function SkillPhaseParam_Trajectory:GetTargetEffectID()
  return self._targetEffectID
end

function SkillPhaseParam_Trajectory:GetTargetDelayTime()
  return self._targetDelayTime
end

function SkillPhaseParam_Trajectory:GetHitAnimation()
  return self._hitAnimationName
end

function SkillPhaseParam_Trajectory:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseParam_Trajectory:GetHitEffectTime()
  return self._hitEffectTime
end

function SkillPhaseParam_Trajectory:GetDamageIndex()
  return self._damageIndex
end

function SkillPhaseParam_Trajectory:IsClearBodyNow()
  if self._clearBodyNow and self._clearBodyNow > 0 then
    return true
  end
  return false
end

function SkillPhaseParam_Trajectory:GetFinishDelayTime()
  return self._finishDelayTime
end
