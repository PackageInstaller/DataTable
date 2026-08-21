require("skill_effect_result_base")
_class("SkillEffectPickUpTrapAndBuffDamageResult", SkillEffectResultBase)
SkillEffectPickUpTrapAndBuffDamageResult = SkillEffectPickUpTrapAndBuffDamageResult

function SkillEffectPickUpTrapAndBuffDamageResult:GetEffectType()
  return SkillEffectType.PickUpTrapAndBuffDamage
end

function SkillEffectPickUpTrapAndBuffDamageResult:Constructor(buffLayer)
  self._tarTrapBuffLayer = buffLayer
end

function SkillEffectPickUpTrapAndBuffDamageResult:GetTarBuffLayer()
  return self._tarTrapBuffLayer
end
