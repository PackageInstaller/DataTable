require("skill_effect_param_base")
_class("SkillMultipleScopesDealMultipleDamageEffectParam", SkillEffectParamBase)
SkillMultipleScopesDealMultipleDamageEffectParam = SkillMultipleScopesDealMultipleDamageEffectParam

function SkillMultipleScopesDealMultipleDamageEffectParam:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
end

function SkillMultipleScopesDealMultipleDamageEffectParam:GetEffectType()
  return SkillEffectType.MultipleScopesDealMultipleDamage
end

function SkillMultipleScopesDealMultipleDamageEffectParam:GetDamagePercent()
  return self._percent
end

function SkillMultipleScopesDealMultipleDamageEffectParam:GetDamageFormulaID()
  return self._formulaID
end
