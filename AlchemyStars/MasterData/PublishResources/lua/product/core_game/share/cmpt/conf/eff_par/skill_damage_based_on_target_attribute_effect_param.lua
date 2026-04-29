require("skill_effect_param_base")
_class("SkillDamageBasedOnTargetAttributeEffectParam", SkillEffectParamBase)
SkillDamageBasedOnTargetAttributeEffectParam = SkillDamageBasedOnTargetAttributeEffectParam

function SkillDamageBasedOnTargetAttributeEffectParam:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._target = t.target or "SkillTarget"
  self._targetAttribute = t.targetAttribute
  self._compare = t.compare or "Self"
  self._compareAttribute = t.compareAttribute
  self._compareParam = t.compareParam or 1
  self._compareSymbol = t.compareSymbol
  self._ownerBuffEffect = t.ownerBuffEffect
  self._preDamageStageIndex = t.preDamageStageIndex
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetTarget()
  return self._target
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetTargetAttribute()
  return self._targetAttribute
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetCompare()
  return self._compare
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetCompareAttribute()
  return self._compareAttribute
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetCompareParam()
  return self._compareParam
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetCompareSymbol()
  return self._compareSymbol
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetOwnerBuffEffect()
  return self._ownerBuffEffect
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetPreDamageStageIndex()
  return self._preDamageStageIndex
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetEffectType()
  return SkillEffectType.DamageBasedOnTargetAttribute
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetDamagePercent()
  return self._percent
end

function SkillDamageBasedOnTargetAttributeEffectParam:GetDamageFormulaID()
  return self._formulaID
end
