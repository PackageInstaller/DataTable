require("skill_phase_param_base")
_class("SkillPhaseParamColumnForward", SkillPhaseParamBase)
SkillPhaseParamColumnForward = SkillPhaseParamColumnForward

function SkillPhaseParamColumnForward:Constructor(t)
  self._gridDelayTime = t.gridDelayTime
  self._gridEffectID = t.gridEffectID
  self._hitEffectID = t.hitEffectID
  self._hitAnimationName = t.hitAnimationName
  self._intervalTime = t.gridIntervalTime
  self._hasDamage = t.hasDamage
  self._hitPointDelay = t.hitPointDelay
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseParamColumnForward:GetPhaseType()
  return SkillViewPhaseType.ColumnForward
end

function SkillPhaseParamColumnForward:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseParamColumnForward:GetEffectIntervalTime()
  return self._intervalTime
end

function SkillPhaseParamColumnForward:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseParamColumnForward:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseParamColumnForward:GetGridDelayTime()
  return self._gridDelayTime
end

function SkillPhaseParamColumnForward:GetHitPointDelay()
  return self._hitPointDelay
end

function SkillPhaseParamColumnForward:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseParamColumnForward:HasDamage()
  if self._hasDamage then
    return self._hasDamage == 1
  else
    return false
  end
end

function SkillPhaseParamColumnForward:GetCacheTable()
  local t = {}
  return t
end
