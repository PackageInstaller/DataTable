DamageEffectCalcType = {Normal = 0, AverageForRecoverHp = 1}
_enum("DamageEffectCalcType", DamageEffectCalcType)
require("skill_effect_param_base")
_class("SkillDamageEffectParam", SkillEffectParamBase)
SkillDamageEffectParam = SkillDamageEffectParam

function SkillDamageEffectParam:Constructor(t)
  self.m_nTargetType = t.target or EnumTargetEntity.All
  self._damageTimes = t.damageTimes or 1
  self._percent = t.percent
  self._formulaID = t.formulaID
  self:_CalcFinalParam()
  self._onceMaxDamageType = t.onceMaxDamageType
  self._onceMaxDamageParam = t.onceMaxDamageParam
  self._onceMinDamageParam = t.onceMinDamageParam
  self._maxAddedDamagePercent = t.maxAddedDamagePercent
  self._addDamagePercent = t.addDamagePercent
  self._calcDamageType = DamageEffectCalcType.Normal
  if t.calcDamageType then
    self._calcDamageType = t.calcDamageType
  end
  self._hpDamagePercent = t.hpDamagePercent
  self.m_nNearPoint = t.nearPoint or 0
  self.crit = t.crit or 1
  self.critProb = t.critProb or 0
  self.addPercent = t.addPercent
  self._ignoreShield = t.ignoreShield == 1
  self._damageIncreaseBuffEffectType = t.damageIncreaseBuffEffectType
  self._damageIncreaseMul = t.damageIncreaseMul
  self._defHPThreshold_117 = t.defHPThreshold_117
  self._damageIncreaseRate_117 = t.damageIncreaseRate_117
  self._maxHPDamagePercent = t.maxHPDamagePercent
  self.BodyAreaPow_119 = t.BodyAreaPow_119
  self._damagePercent_125 = t.damagePercent_125 or 0
  self._spParams137 = {}
  self._spParams137.a = t.spParamA_137 or 1
  self._spParams137.b = t.spParamB_137 or 1
  self._spParams137.c = t.spParamC_137 or 0
  self._spParams137.d = t.spParamD_137 or 0
  self._spParams137.e = t.spParamE_137 or 1
  self._spParams137.f = t.spParamF_137 or 0
  self._spParams137.layerBuffEffect = t.spParamLayerBuffEffect_137
  self._spParams137.weakBuffEffect = t.spParamWeakBuffEffect_137
  self._damageMulMin138 = t.damageMulMin138
  self._damageMulMax138 = t.damageMulMax138
  self._pureDamage = t.pureDamage or 0
  self._useTrapAttackTrapID = t.useTrapAttackTrapID
  self._percentLayerType_143 = t.percentLayerType_143
  self._percentByLayer_143 = t.percentByLayer_143
  self._absoluteRemainHP_145 = t.absoluteRemainHP_145
  self._useScopeOrder = t.useScopeOrder or 0
  self._n33DamageMul = t.n33DamageMul or 1
  self._chainBasePercent_158 = t.chainBasePercent_158
  self._chainIndex = t.chainIndex
  self._hpPercent_161 = t.hpPercent_161
  self._percent_163 = t.percent_163
  self._fixedDamage = t.fixedDamage or 0
  self._layer = t.layer
  self._bonusPerGrid = t.bonusPerGrid or 0
  self.buffID = t.buffID
  self.layerCostPct = t.layerCostPct
  self.layerDmgPct = t.layerDmgPct
end

function SkillDamageEffectParam:GetDamageIncreaseBuffEffectType()
  return self._damageIncreaseBuffEffectType
end

function SkillDamageEffectParam:GetDamageIncreaseMul()
  return self._damageIncreaseMul
end

function SkillDamageEffectParam:GetCalcDamageType()
  return self._calcDamageType
end

function SkillDamageEffectParam:GetHpDamagePercent()
  return self._hpDamagePercent
end

function SkillDamageEffectParam:GetMaxAddedDamagePercent()
  return self._maxAddedDamagePercent
end

function SkillDamageEffectParam:GetAddDamagePercent()
  return self._addDamagePercent
end

function SkillDamageEffectParam:GetEffectType()
  return SkillEffectType.Damage
end

function SkillDamageEffectParam:GetTargetType()
  return self.m_nTargetType
end

function SkillDamageEffectParam:GetDamageTimes()
  return self._damageTimes
end

function SkillDamageEffectParam:GetDamagePercent()
  return self._percent
end

function SkillDamageEffectParam:GetDamageFormulaID()
  return self._formulaID
end

function SkillDamageEffectParam:_CalcFinalParam()
  self:_CalcFinalPercent()
end

function SkillDamageEffectParam:_CalcFinalPercent()
  if not self._percent then
    return
  end
  local skillAwakeAndGradeParam = self:GetSKillAwakeAndGradeParam()
  if not skillAwakeAndGradeParam then
    return
  end
  if type(skillAwakeAndGradeParam) ~= "table" or skillAwakeAndGradeParam.percent == nil then
    return
  end
  local paramPercent = skillAwakeAndGradeParam.percent
  local newPercent = {}
  for k, v in ipairs(self._percent) do
    if paramPercent[k] then
      newPercent[k] = v + paramPercent[k]
    else
      newPercent[k] = self._percent[k]
    end
  end
  self._percent = newPercent
end

function SkillDamageEffectParam:GetOnceMaxDamageType()
  return self._onceMaxDamageType
end

function SkillDamageEffectParam:GetOnceMaxDamageParam()
  return self._onceMaxDamageParam
end

function SkillDamageEffectParam:GetOnceMinDamageParam()
  return self._onceMinDamageParam
end

function SkillDamageEffectParam:GetNearPoint()
  return self.m_nNearPoint
end

function SkillDamageEffectParam:GetHPThresholdFormula117()
  return self._defHPThreshold_117
end

function SkillDamageEffectParam:GetDamageIncreaseRateFormula117()
  return self._damageIncreaseRate_117
end

function SkillDamageEffectParam:GetMaxHPDamagePercent()
  return self._maxHPDamagePercent
end

function SkillDamageEffectParam:GetAttackPercentFormula125()
  return self._damagePercent_125
end

function SkillDamageEffectParam:GetPureDamage()
  return self._pureDamage
end

function SkillDamageEffectParam:GetUseTrapAttackTrapID()
  return self._useTrapAttackTrapID
end

function SkillDamageEffectParam:GetDamageSpParamsFormula137()
  return self._spParams137
end

function SkillDamageEffectParam:GetBuffLayerTypeFormula143()
  return self._percentLayerType_143
end

function SkillDamageEffectParam:GetPercentByLayerFormula143()
  return self._percentByLayer_143
end

function SkillDamageEffectParam:GetAbsoluteRemainHPFormula145()
  return self._absoluteRemainHP_145
end

function SkillDamageEffectParam:IsIgnoreShield()
  return self._ignoreShield
end

function SkillDamageEffectParam:GetUseScopeOrder()
  return self._useScopeOrder
end

function SkillDamageEffectParam:SetN33DamageMul(n33DamageMul)
  self._n33DamageMul = n33DamageMul
end

function SkillDamageEffectParam:GetN33DamageMul()
  return self._n33DamageMul
end

function SkillDamageEffectParam:GetChainBasePercentFormula158()
  return self._chainBasePercent_158
end

function SkillDamageEffectParam:GetChainIndex()
  return self._chainIndex
end

function SkillDamageEffectParam:SetChainIndex(chainIndex)
  self._chainIndex = chainIndex
end

function SkillDamageEffectParam:GetHpPercent161()
  return self._hpPercent_161
end

function SkillDamageEffectParam:GetPercent163()
  return self._percent_163
end

function SkillDamageEffectParam:GetFixedDamage()
  return self._fixedDamage
end

function SkillDamageEffectParam:GetLayerForFixedDamage()
  return self._layer
end

function SkillDamageEffectParam:GetBonusPerGrid()
  return self._bonusPerGrid
end
