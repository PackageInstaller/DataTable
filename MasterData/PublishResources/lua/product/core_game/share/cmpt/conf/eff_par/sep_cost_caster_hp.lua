require("skill_damage_effect_param")
_class("SkillEffectCostCasterHPParam", SkillEffectParamBase)
SkillEffectCostCasterHPParam = SkillEffectCostCasterHPParam
local SkillEffectCostCasterHPType = {CurHPPercent = 1, MaxHPPercent = 2}
_enum("SkillEffectCostCasterHPType", SkillEffectCostCasterHPType)

function SkillEffectCostCasterHPParam:Constructor(t)
  self._costType = t.costType
  self._costPercent = t.costPercent
  local ignoreShieldParam = t.ignoreShield or 1
  self._ignoreShield = tonumber(ignoreShieldParam) == 1
  self._leastHP = t.leastHP
end

function SkillEffectCostCasterHPParam:GetEffectType()
  return SkillEffectType.CostCasterHP
end

function SkillEffectCostCasterHPParam:GetCostType()
  return self._costType
end

function SkillEffectCostCasterHPParam:GetCostPercent()
  return self._costPercent
end

function SkillEffectCostCasterHPParam:GetIgnoreShield()
  return self._ignoreShield
end

function SkillEffectCostCasterHPParam:GetLeastHP()
  return self._leastHP
end
