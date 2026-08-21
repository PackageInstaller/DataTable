require("skill_damage_effect_param")
_class("SkillEffectParamChangeSanMax", SkillEffectParamBase)
SkillEffectParamChangeSanMax = SkillEffectParamChangeSanMax

function SkillEffectParamChangeSanMax:Constructor(t)
  self._val = t.val
end

function SkillEffectParamChangeSanMax:GetEffectType()
  return SkillEffectType.ChangeSanMax
end

function SkillEffectParamChangeSanMax:GetChangeValue()
  return self._val
end
