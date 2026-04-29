require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectParamTransferMonsterWeak", SkillDamageEffectParam)
SkillEffectParamTransferMonsterWeak = SkillEffectParamTransferMonsterWeak

function SkillEffectParamTransferMonsterWeak:Constructor(t)
  self._petTemplateID = t.petTemplateID
end

function SkillEffectParamTransferMonsterWeak:GetEffectType()
  return SkillEffectType.TransferMonsterWeak
end

function SkillEffectParamTransferMonsterWeak:GetPetTemplateID()
  return self._petTemplateID
end
