_class("SkillPhaseParam_RandAttack", SkillPhaseParamBase)
SkillPhaseParam_RandAttack = SkillPhaseParam_RandAttack

function SkillPhaseParam_RandAttack:Constructor(t)
  self._castAnimation = t.castAnimation
  self._castEffectID = t.castEffectID
  self._castEffectTime = t.castEffectTime
  self._castAnimation_2 = t.castAnimation_2
  self._castEffectID_2 = t.castEffectID_2
  self._castEffectTime_2 = t.castEffectTime_2
  self._targetWaitTime = t.targetWaitTime
  self._targetEffectID = t.targetEffectID
  self._targetEffectTime = t.targetEffectTime
  self._hitAnim = t.hitAnim
  self._hitEffectId = t.hitEffectId
  self._attackIntervalTime = t.attackIntervalTime
  self._finishDelayTime = t.finishDelayTime
  self._clearBodyNow = t.clearBodyNow
  self._audioID = t.audioID or 0
  self._audioWaitTime = t.audioWaitTime or 0
end

function SkillPhaseParam_RandAttack:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._castEffectID)
  self:AddEffectIDToListID(listID, self._castEffectID_2)
  self:AddEffectIDToListID(listID, self._targetEffectID)
  self:AddEffectIDToListID(listID, self._hitEffectId)
  self:AddEffectIDToListID(listID, self._endEffectID_1)
  self:AddEffectIDToListID(listID, self._endEffectID_2)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseParam_RandAttack:GetSoundCacheTable()
  if not self._audioID or self._audioID <= 0 then
    return
  end
  return {
    self._audioID
  }
end

function SkillPhaseParam_RandAttack:GetPhaseType()
  return SkillViewPhaseType.RandAttack
end

function SkillPhaseParam_RandAttack:GetCastAnimation()
  return self._castAnimationName
end

function SkillPhaseParam_RandAttack:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseParam_RandAttack:GetCastEffectTime()
  return self._castEffectTime
end

function SkillPhaseParam_RandAttack:GetTargetWaitTime()
  return self._targetWaitTime
end

function SkillPhaseParam_RandAttack:GetTargetEffectID()
  return self._targetEffectID
end

function SkillPhaseParam_RandAttack:GetTargetEffectTime()
  return self._targetEffectTime
end

function SkillPhaseParam_RandAttack:GetHitAnimation()
  return self._hitAnim
end

function SkillPhaseParam_RandAttack:GetHitEffectID()
  return self._hitEffectId
end

function SkillPhaseParam_RandAttack:GetAttackIntervalTime()
  return self._attackIntervalTime
end

function SkillPhaseParam_RandAttack:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseParam_RandAttack:GetAudioID()
  return self._audioID
end

function SkillPhaseParam_RandAttack:GetAudioWaitTime()
  return self._audioWaitTime
end
