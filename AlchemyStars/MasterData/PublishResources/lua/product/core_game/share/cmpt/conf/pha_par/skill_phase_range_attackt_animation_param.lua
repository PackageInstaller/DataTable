require("skill_phase_param_base")
local SkillPhaseParam_RangeAttack_TrajectoryType = {
  Line = 1,
  Parabola = 2,
  Laser = 3
}
_enum("SkillPhaseParam_RangeAttack_TrajectoryType", SkillPhaseParam_RangeAttack_TrajectoryType)
_class("SkillPhaseRangeAttackAnimationParam", SkillPhaseParamBase)
SkillPhaseRangeAttackAnimationParam = SkillPhaseRangeAttackAnimationParam

function SkillPhaseRangeAttackAnimationParam:Constructor(t)
  self._castEffectID = t.castEffectID
  self._castAnimation = t.castAnimationName
  self._hitDelayTime = t.hitDelayTime
  self._trajectoryType = t.trajectoryType
  self._trajectoryEffectID = t.trajectoryEffectID
  self._trajectoryEffectOffset = t.trajectoryEffectOffset
  self._trajectoryTime = t.trajectoryTime
  self._targetEffectID = t.targetEffectID
  self._hpDelay = t.hpDelay or 0
  self._hitEffectID = t.hitEffectID
  self._hitAnimationName = t.hitAnimationName
  self._finishDelayTime = t.finishDelayTime
  self._clearBodyNow = t.clearBodyNow
  self._audioID = t.audioID or 0
  self._audioWaitTime = t.audioWaitTime or 0
  self._playBySuperEntity = t.playBySuperEntity == 1
end

function SkillPhaseRangeAttackAnimationParam:GetCacheTable()
  local listID = {}
  if type(self._castEffectID) == "table" then
    for k, v in ipairs(self._castEffectID) do
      self:AddEffectIDToListID(listID, v)
    end
  else
    self:AddEffectIDToListID(listID, self._castEffectID)
  end
  self:AddEffectIDToListID(listID, self._trajectoryEffectID)
  self:AddEffectIDToListID(listID, self._targetEffectID)
  self:AddEffectIDToListID(listID, self._hitEffectID)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseRangeAttackAnimationParam:GetSoundCacheTable()
  if not self._audioID or self._audioID <= 0 then
    return
  end
  return {
    self._audioID
  }
end

function SkillPhaseRangeAttackAnimationParam:GetPhaseType()
  return SkillViewPhaseType.RangeAttackAnimation
end

function SkillPhaseRangeAttackAnimationParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseRangeAttackAnimationParam:GetCastAnimation()
  return self._castAnimation
end

function SkillPhaseRangeAttackAnimationParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseRangeAttackAnimationParam:GetHitAnimation()
  return self._hitAnimationName
end

function SkillPhaseRangeAttackAnimationParam:GetHitDelayTime()
  return self._hitDelayTime
end

function SkillPhaseRangeAttackAnimationParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseRangeAttackAnimationParam:GetTrajectoryType()
  return self._trajectoryType
end

function SkillPhaseRangeAttackAnimationParam:GetTrajectoryEffectID()
  return self._trajectoryEffectID
end

function SkillPhaseRangeAttackAnimationParam:GetTrajectoryEffectOffset()
  return self._trajectoryEffectOffset
end

function SkillPhaseRangeAttackAnimationParam:GetTrajectoryTime()
  return self._trajectoryTime
end

function SkillPhaseRangeAttackAnimationParam:GetHpDelay()
  return self._hpDelay
end

function SkillPhaseRangeAttackAnimationParam:GetTargetEffectID()
  return self._targetEffectID
end

function SkillPhaseRangeAttackAnimationParam:IsClearBodyNow()
  if self._clearBodyNow and self._clearBodyNow > 0 then
    return true
  end
  return false
end

function SkillPhaseRangeAttackAnimationParam:GetAudioID()
  return self._audioID
end

function SkillPhaseRangeAttackAnimationParam:GetAudioWaitTime()
  return self._audioWaitTime
end

function SkillPhaseRangeAttackAnimationParam:IsPlayOnSuperEntity()
  return self._playBySuperEntity
end
