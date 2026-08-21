require("skill_effect_param_base")
_class("SkillDamageBasedOnPickUpRectEffectParam", SkillEffectParamBase)
SkillDamageBasedOnPickUpRectEffectParam = SkillDamageBasedOnPickUpRectEffectParam

function SkillDamageBasedOnPickUpRectEffectParam:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._multiple = t.multiple or 1
  self._rectX = 1
  self._rectY = 1
end

function SkillDamageBasedOnPickUpRectEffectParam:GetEffectType()
  return SkillEffectType.DamageBasedOnPickUpRect
end

function SkillDamageBasedOnPickUpRectEffectParam:GetMultiple()
  return self._multiple
end

function SkillDamageBasedOnPickUpRectEffectParam:GetDamagePercent()
  local damageEffectParam = self._multiple / (self._rectX + self._rectY) * self._percent[1]
  return {damageEffectParam}
end

function SkillDamageBasedOnPickUpRectEffectParam:GetDamageFormulaID()
  return self._formulaID
end

function SkillDamageBasedOnPickUpRectEffectParam:SetSkillRangeRectParam(rectX, rectY)
  self._rectX = rectX
  self._rectY = rectY
end
