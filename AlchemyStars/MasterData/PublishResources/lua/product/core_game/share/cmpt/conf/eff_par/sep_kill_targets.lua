require("skill_effect_param_base")
_class("SkillEffectParamKillTargets", SkillEffectParamBase)
SkillEffectParamKillTargets = SkillEffectParamKillTargets

function SkillEffectParamKillTargets:Constructor(t)
end

function SkillEffectParamKillTargets:GetEffectType()
  return SkillEffectType.KillTargets
end
