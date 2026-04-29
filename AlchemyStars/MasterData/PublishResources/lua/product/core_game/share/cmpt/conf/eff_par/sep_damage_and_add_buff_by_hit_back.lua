require("skill_effect_param_base")
_class("SkillEffectDamageAndAddBuffByHitBackParam", SkillEffectParamBase)
SkillEffectDamageAndAddBuffByHitBackParam = SkillEffectDamageAndAddBuffByHitBackParam

function SkillEffectDamageAndAddBuffByHitBackParam:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._buffID = t.buffID
  self._transmitDamage = t.transmitDamage or false
end

function SkillEffectDamageAndAddBuffByHitBackParam:GetEffectType()
  return SkillEffectType.DamageAndAddBuffByHitBack
end

function SkillEffectDamageAndAddBuffByHitBackParam:GetPercent()
  return self._percent
end

function SkillEffectDamageAndAddBuffByHitBackParam:GetFormulaID()
  return self._formulaID
end

function SkillEffectDamageAndAddBuffByHitBackParam:GetBuffID()
  return self._buffID
end

function SkillEffectDamageAndAddBuffByHitBackParam:IsTransmitDamage()
  return self._transmitDamage
end
