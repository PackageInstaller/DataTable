require("skill_effect_param_base")
_class("SkillEffectParamScorpionHitBack", SkillHitBackEffectParam)
SkillEffectParamScorpionHitBack = SkillEffectParamScorpionHitBack

function SkillEffectParamScorpionHitBack:Constructor(t)
end

function SkillEffectParamScorpionHitBack:GetEffectType()
  return SkillEffectType.ScorpionHitBack
end
