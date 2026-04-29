require("skill_effect_param_base")
_class("SkillAddGridEffectParam", SkillEffectParamBase)
SkillAddGridEffectParam = SkillAddGridEffectParam

function SkillAddGridEffectParam:Constructor(t)
  self._targetGridEffectType = t.gridEffectType
  self._gridConvertType = t.gridConvertType
  self._summonTrap = t.summonTrap or BattleConst.PrismTrapID
  self._ignoreConvertForAny = t.ignoreConvertForAny
  self._ignoreConvertForBlock = t.ignoreConvertForBlock
  self._count = t.count
end

function SkillAddGridEffectParam:GetEffectType()
  return SkillEffectType.AddGridEffect
end

function SkillAddGridEffectParam:GetTargetGridEffectType()
  return self._targetGridEffectType
end

function SkillAddGridEffectParam:GetGridConvertType()
  return self._gridConvertType
end

function SkillAddGridEffectParam:GetSummonTrap()
  return self._summonTrap
end

function SkillAddGridEffectParam:GetIgnoreConvertForAny()
  return self._ignoreConvertForAny
end

function SkillAddGridEffectParam:GetCount()
  return self._count
end

function SkillAddGridEffectParam:GetIgnoreConvertForBlock()
  return self._ignoreConvertForBlock
end
