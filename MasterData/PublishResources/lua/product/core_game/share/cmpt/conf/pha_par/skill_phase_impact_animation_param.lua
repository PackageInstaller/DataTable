require("skill_phase_param_base")
_class("SkillPhaseImpactAnimationParam", SkillPhaseParamBase)
SkillPhaseImpactAnimationParam = SkillPhaseImpactAnimationParam

function SkillPhaseImpactAnimationParam:Constructor(t)
  self._showDelay = t.showDelay
end

function SkillPhaseImpactAnimationParam:GetCacheTable()
  local t = {}
  return t
end

function SkillPhaseImpactAnimationParam:GetPhaseType()
  return SkillViewPhaseType.ImpactAnimation
end

function SkillPhaseImpactAnimationParam:GetShowDelay()
  return self._showDelay
end
