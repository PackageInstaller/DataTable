require("skill_effect_result_base")
_class("SkillEffectCostCasterHPResult", SkillEffectResultBase)
SkillEffectCostCasterHPResult = SkillEffectCostCasterHPResult

function SkillEffectCostCasterHPResult:Constructor(percent, costType, ignoreShield, leastHP)
  self._percent = percent
  self._costType = costType
  self._ignoreShield = ignoreShield
  self._damageInfo = nil
  self._leastHP = leastHP
end

function SkillEffectCostCasterHPResult:GetEffectType()
  return SkillEffectType.CostCasterHP
end

function SkillEffectCostCasterHPResult:GetPercent()
  return self._percent
end

function SkillEffectCostCasterHPResult:GetCostType()
  return self._costType
end

function SkillEffectCostCasterHPResult:GetIgnoreShield()
  return self._ignoreShield
end

function SkillEffectCostCasterHPResult:GetDamageInfo()
  return self._damageInfo
end

function SkillEffectCostCasterHPResult:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function SkillEffectCostCasterHPResult:GetLeastHP()
  return self._leastHP
end
