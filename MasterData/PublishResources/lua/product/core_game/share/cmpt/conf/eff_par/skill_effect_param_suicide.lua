require("skill_damage_effect_param")
_class("SkillEffectParamSuicide", SkillEffectParamBase)
SkillEffectParamSuicide = SkillEffectParamSuicide

function SkillEffectParamSuicide:Constructor(t)
end

function SkillEffectParamSuicide:GetEffectType()
  return SkillEffectType.Suicide
end
