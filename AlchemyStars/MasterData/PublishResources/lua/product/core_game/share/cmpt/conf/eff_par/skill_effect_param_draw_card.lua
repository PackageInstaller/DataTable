require("skill_effect_param_base")
_class("SkillEffectParamDrawCard", SkillEffectParamBase)
SkillEffectParamDrawCard = SkillEffectParamDrawCard

function SkillEffectParamDrawCard:Constructor(t)
end

function SkillEffectParamDrawCard:GetEffectType()
  return SkillEffectType.DrawCard
end
