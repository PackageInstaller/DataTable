_class("SkillEffectResult_DynamicScopeChainDamage", SkillEffectResultBase)
SkillEffectResult_DynamicScopeChainDamage = SkillEffectResult_DynamicScopeChainDamage
SkillEffectResult_DynamicScopeChainDamage.__EFFECT_TYPE = SkillEffectType.DynamicCenterDamage

function SkillEffectResult_DynamicScopeChainDamage:Constructor(damageScope, damageResults)
  self._damageScope = damageScope
  self._damageResults = damageResults or {}
end

function SkillEffectResult_DynamicScopeChainDamage:GetDamageScope()
  return self._damageScope
end

function SkillEffectResult_DynamicScopeChainDamage:GetDamageResults()
  return self._damageResults
end
