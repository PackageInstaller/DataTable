require("skill_damage_effect_param")
_class("SkillEffectAbsorbTrapsAndDamageByPickupTargetParam", SkillEffectParamBase)
SkillEffectAbsorbTrapsAndDamageByPickupTargetParam = SkillEffectAbsorbTrapsAndDamageByPickupTargetParam

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:Constructor(t)
  self._trapID = t.trapID
  self._basePercent = t.basePercent
  self._addPercent = t.addPercent or 0
  self._limitPercent = t.limitPercent
  self._formulaID = t.formulaID
  self._damageScopeType = t.damageScopeType
  self._damageScopeParam = t.damageScopeParam
  self._damageScopeCenterType = t.damageScopeCenterType
  self._damageTargetType = t.damageTargetType
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetEffectType()
  return SkillEffectType.AbsorbTrapsAndDamageByPickupTarget
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetTrapID()
  return self._trapID
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetBasePercent()
  return self._basePercent
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetAddPercent()
  return self._addPercent
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetLimitPercent()
  return self._limitPercent
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetFormulaID()
  return self._formulaID
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetDamageScopeType()
  return self._damageScopeType
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetDamageScopeParam()
  return self._damageScopeParam
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetDamageScopeCenterType()
  return self._damageScopeCenterType
end

function SkillEffectAbsorbTrapsAndDamageByPickupTargetParam:GetDamageTargetType()
  return self._damageTargetType
end
