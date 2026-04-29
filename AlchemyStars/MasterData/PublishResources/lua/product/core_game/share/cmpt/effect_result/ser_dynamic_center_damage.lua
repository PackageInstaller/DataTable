_class("SkillEffectResult_DynamicCenterDamage", SkillEffectResultBase)
SkillEffectResult_DynamicCenterDamage = SkillEffectResult_DynamicCenterDamage
SkillEffectResult_DynamicCenterDamage.__EFFECT_TYPE = SkillEffectType.DynamicCenterDamage

function SkillEffectResult_DynamicCenterDamage:Constructor(damageScope, damageResults, finalCenter)
  self._damageScope = damageScope
  self._damageResults = damageResults or {}
  self._finalCenter = finalCenter or Vector2.zero
end

function SkillEffectResult_DynamicCenterDamage:GetDamageScope()
  return self._damageScope
end

function SkillEffectResult_DynamicCenterDamage:GetDamageResults()
  return self._damageResults
end

function SkillEffectResult_DynamicCenterDamage:GetFinalCenter()
  return self._finalCenter
end
