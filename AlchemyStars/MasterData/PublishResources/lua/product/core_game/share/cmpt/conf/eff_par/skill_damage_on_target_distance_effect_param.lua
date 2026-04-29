require("skill_effect_param_base")
_class("SkillDamageOnTargetDistanceEffectParam", SkillEffectParamBase)
SkillDamageOnTargetDistanceEffectParam = SkillDamageOnTargetDistanceEffectParam

function SkillDamageOnTargetDistanceEffectParam:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._targetCount = t.targetCount or 1
  self._baseValue = t.baseValue or 0
  self._changeValue = t.changeValue or 0
  self._skillIncreaseType = t.skillIncreaseType or ModifySkillIncreaseParamType.ActiveSkill
  self._chainBasePercent_158 = t.chainBasePercent_158
  self._buffID = t.buffID
  self._layerCostPct = t.layerCostPct
  self._layerDmgPct = t.layerDmgPct
end

function SkillDamageOnTargetDistanceEffectParam:GetChainBasePercentFormula158()
  return self._chainBasePercent_158
end

function SkillDamageOnTargetDistanceEffectParam:GetTargetCount()
  return self._targetCount
end

function SkillDamageOnTargetDistanceEffectParam:GetBaseValue()
  return self._baseValue
end

function SkillDamageOnTargetDistanceEffectParam:GetChangeValue()
  return self._changeValue
end

function SkillDamageOnTargetDistanceEffectParam:GetSkillIncreaseType()
  return self._skillIncreaseType
end

function SkillDamageOnTargetDistanceEffectParam:GetEffectType()
  return SkillEffectType.DamageOnTargetDistance
end

function SkillDamageOnTargetDistanceEffectParam:GetDamagePercent()
  return self._percent
end

function SkillDamageOnTargetDistanceEffectParam:GetDamageFormulaID()
  return self._formulaID
end

function SkillDamageOnTargetDistanceEffectParam:GetBuffID()
  return self._buffID
end

function SkillDamageOnTargetDistanceEffectParam:GetLayerCostPct()
  return self._layerCostPct
end

function SkillDamageOnTargetDistanceEffectParam:GetLayerDmgPct()
  return self._layerDmgPct
end
