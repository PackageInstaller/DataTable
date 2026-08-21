require("skill_effect_param_base")
_class("SkillAddComboNumEffectParam", SkillEffectParamBase)
SkillAddComboNumEffectParam = SkillAddComboNumEffectParam

function SkillAddComboNumEffectParam:Constructor(t)
end

function SkillAddComboNumEffectParam:GetEffectType()
  return SkillEffectType.AddComboNum
end
