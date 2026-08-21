require("skill_effect_param_base")
_class("SkillEffectParam_AddDimensionFlag", SkillEffectParamBase)
SkillEffectParam_AddDimensionFlag = SkillEffectParam_AddDimensionFlag

function SkillEffectParam_AddDimensionFlag:Constructor(t)
end

function SkillEffectParam_AddDimensionFlag:GetEffectType()
  return SkillEffectType.AddDimensionFlag
end
