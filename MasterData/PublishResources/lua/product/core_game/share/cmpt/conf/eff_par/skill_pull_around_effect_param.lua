require("skill_effect_param_base")
_class("SkillPullAroundEffectParam", SkillEffectParamBase)
SkillPullAroundEffectParam = SkillPullAroundEffectParam

function SkillPullAroundEffectParam:Constructor()
end

function SkillPullAroundEffectParam:GetEffectType()
  return SkillEffectType.PullAround
end
