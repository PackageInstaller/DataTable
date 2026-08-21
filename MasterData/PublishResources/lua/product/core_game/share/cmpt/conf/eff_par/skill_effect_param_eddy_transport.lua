require("skill_effect_param_base")
_class("SkillEffectParam_EddyTransport", SkillEffectParamBase)
SkillEffectParam_EddyTransport = SkillEffectParam_EddyTransport

function SkillEffectParam_EddyTransport:Constructor(t)
end

function SkillEffectParam_EddyTransport:GetEffectType()
  return SkillEffectType.EddyTransport
end
