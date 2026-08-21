require("skill_effect_param_base")
_class("SkillEffectParamMoveTrap", SkillEffectParamBase)
SkillEffectParamMoveTrap = SkillEffectParamMoveTrap

function SkillEffectParamMoveTrap:Constructor(t)
  self._trapID = t.trapID
  self._moveScopeType = t.moveScopeType
  self._moveScopeParam = t.moveScopeParam or {}
end

function SkillEffectParamMoveTrap:GetEffectType()
  return SkillEffectType.MoveTrap
end

function SkillEffectParamMoveTrap:GetTrapID()
  return self._trapID
end

function SkillEffectParamMoveTrap:GetMoveScopeType()
  return self._moveScopeType
end

function SkillEffectParamMoveTrap:GetMoveScopeParam()
  return self._moveScopeParam
end
