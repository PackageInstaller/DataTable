require("skill_damage_effect_param")
_class("SkillEffectKillPlayerParam", SkillEffectParamBase)
SkillEffectKillPlayerParam = SkillEffectKillPlayerParam

function SkillEffectKillPlayerParam:Constructor(t)
end

function SkillEffectKillPlayerParam:GetEffectType()
  return SkillEffectType.KillPlayer
end
