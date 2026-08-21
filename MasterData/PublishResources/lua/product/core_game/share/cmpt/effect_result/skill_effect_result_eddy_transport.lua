require("skill_effect_result_teleport")
_class("SkillEffectResult_EddyTransport", SkillEffectResult_Teleport)
SkillEffectResult_EddyTransport = SkillEffectResult_EddyTransport

function SkillEffectResult_EddyTransport:GetEffectType()
  return SkillEffectType.EddyTransport
end
