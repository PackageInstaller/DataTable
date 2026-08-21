require("skill_damage_effect_param")
_class("SkillEffectParam_DynamicCenterDamage", SkillDamageEffectParam)
SkillEffectParam_DynamicCenterDamage = SkillEffectParam_DynamicCenterDamage

function SkillEffectParam_DynamicCenterDamage:Constructor(t)
  self._centerScopeType = t.centerScopeType
  local scopeParser = SkillScopeParamParser:New()
  self._centerScopeParam = scopeParser:ParseScopeParam(self._centerScopeType, t.centerScopeParam)
  SkillEffectParam_DynamicCenterDamage.super.Constructor(self, t)
end

function SkillEffectParam_DynamicCenterDamage:GetEffectType()
  return SkillEffectType.DynamicCenterDamage
end

function SkillEffectParam_DynamicCenterDamage:GetCenterScopeType()
  return self._centerScopeType
end

function SkillEffectParam_DynamicCenterDamage:GetCenterScopeParam()
  return self._centerScopeParam
end
