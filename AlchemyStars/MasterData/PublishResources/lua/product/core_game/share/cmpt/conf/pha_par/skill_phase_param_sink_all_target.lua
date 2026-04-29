require("skill_phase_param_base")
_class("SkillPhaseParamSinkAllTarget", SkillPhaseParamBase)
SkillPhaseParamSinkAllTarget = SkillPhaseParamSinkAllTarget

function SkillPhaseParamSinkAllTarget:Constructor(t)
  self._effectId = t.effectID
  self._intervalTime = t.intervalTime
  self._effectScale = t.effectScale
  self._downDis = t.downDisance
  self._waitDownTime = t.waitDownTime
  self._downTime = t.downTime
  self._waitTime = t.waitTime
  self._upTime = t.upTime
  self._waitDamageTime = t.waitDamageTime
  self._hitEffectId = t.hitEffectID
  self._hitAnimName = t.hitAnimName
  self._doNotHideTarget = tonumber(t.doNotHideTarget) == 1
end

function SkillPhaseParamSinkAllTarget:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._effectId)
  self:AddEffectIDToListID(listID, self._hitEffectId)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseParamSinkAllTarget:GetPhaseType()
  return SkillViewPhaseType.SinkAllTarget
end

function SkillPhaseParamSinkAllTarget:GetEffectId()
  return self._effectId
end

function SkillPhaseParamSinkAllTarget:GetIntervalTime()
  return self._intervalTime
end

function SkillPhaseParamSinkAllTarget:GetEffectScale()
  return self._effectScale
end

function SkillPhaseParamSinkAllTarget:GetWaitDownTime()
  return self._waitDownTime
end

function SkillPhaseParamSinkAllTarget:GetDownDistance()
  return self._downDis
end

function SkillPhaseParamSinkAllTarget:GetDownTime()
  return self._downTime
end

function SkillPhaseParamSinkAllTarget:GetWaitTime()
  return self._waitTime
end

function SkillPhaseParamSinkAllTarget:GetUpTime()
  return self._upTime
end

function SkillPhaseParamSinkAllTarget:GetWaitDamageTime()
  return self._waitDamageTime
end

function SkillPhaseParamSinkAllTarget:GetHitEffectId()
  return self._hitEffectId
end

function SkillPhaseParamSinkAllTarget:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseParamSinkAllTarget:DoNotHideTarget()
  return self._doNotHideTarget
end
