require("skill_effect_param_base")
_class("SkillEffectParamClingySummon", SkillEffectParam_SummonEverything)
SkillEffectParamClingySummon = SkillEffectParamClingySummon

function SkillEffectParamClingySummon:Constructor(t)
end

function SkillEffectParamClingySummon:GetEffectType()
  return SkillEffectType.ClingySummon
end
