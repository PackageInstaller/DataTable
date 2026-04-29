require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectDamageCountByBuffLayer2Param", SkillDamageEffectParam)
SkillEffectDamageCountByBuffLayer2Param = SkillEffectDamageCountByBuffLayer2Param

function SkillEffectDamageCountByBuffLayer2Param:Constructor(t)
  self._buffEffectType = t.buffEffectType
  self._buffPreCount = t.buffPreCount or 1
  self._effectScopeType = t.effectScopeType
  local scopeParser = SkillScopeParamParser:New()
  self._effectScopeParam = scopeParser:ParseScopeParam(self._effectScopeType, t.effectScopeParam)
  self._effectTargetType = t.effectTargetType or SkillTargetType.MonsterTrap
  self._effectCenterType = t.effectCenterType or SkillSplashCenterType.Caster
end

function SkillEffectDamageCountByBuffLayer2Param:GetMyEffectScopeType()
  return self._effectScopeType
end

function SkillEffectDamageCountByBuffLayer2Param:GetMyEffectScopeParam()
  return self._effectScopeParam
end

function SkillEffectDamageCountByBuffLayer2Param:GetMyEffectTargetType()
  return self._effectTargetType
end

function SkillEffectDamageCountByBuffLayer2Param:GetMyEffectCenterType()
  return self._effectCenterType
end

function SkillEffectDamageCountByBuffLayer2Param:GetBuffPreCount()
  return self._buffPreCount
end

function SkillEffectDamageCountByBuffLayer2Param:GetEffectType()
  return SkillEffectType.DamageCountByBuffLayer2
end

function SkillEffectDamageCountByBuffLayer2Param:GetAddPercentBuffEffectType()
  return self._buffEffectType
end
