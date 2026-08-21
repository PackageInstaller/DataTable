require("skill_damage_effect_param")
_class("SkillEffectTransferTargetParam", SkillEffectParamBase)
SkillEffectTransferTargetParam = SkillEffectTransferTargetParam

function SkillEffectTransferTargetParam:Constructor(t)
end

function SkillEffectTransferTargetParam:GetEffectType()
  return SkillEffectType.TransferTarget
end
