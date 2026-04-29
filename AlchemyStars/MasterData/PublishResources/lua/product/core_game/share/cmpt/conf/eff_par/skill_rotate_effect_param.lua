require("skill_effect_param_base")
_class("SkillRotateEffectParam", SkillEffectParamBase)
SkillRotateEffectParam = SkillRotateEffectParam

function SkillRotateEffectParam:Constructor(t)
  self._isClockwise = t.isClockwise or false
end

function SkillRotateEffectParam:GetEffectType()
  return SkillEffectType.Rotate
end

function SkillRotateEffectParam:IsClockwise()
  return self._isClockwise
end
