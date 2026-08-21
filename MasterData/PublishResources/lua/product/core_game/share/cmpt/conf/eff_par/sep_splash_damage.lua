require("skill_damage_effect_param")
_class("SkillEffectParamSplashDamage", SkillDamageEffectParam)
SkillEffectParamSplashDamage = SkillEffectParamSplashDamage

function SkillEffectParamSplashDamage:Constructor(t)
  self._splashRate = t.splashRate
  self._splashScopeType = t.splashScopeType
  self._splashScopeParam = t.splashScopeParam
  self._baseDamageStageIndex = t.baseDamageStageIndex or 1
end

function SkillEffectParamSplashDamage:GetEffectType()
  return SkillEffectType.SplashDamage
end

function SkillEffectParamSplashDamage:GetSplashRate()
  return self._splashRate
end

function SkillEffectParamSplashDamage:GetSplashScopeType()
  return self._splashScopeType
end

function SkillEffectParamSplashDamage:GetSplashScopeParam()
  return self._splashScopeParam
end

function SkillEffectParamSplashDamage:GetBaseDamageStageIndex()
  return self._baseDamageStageIndex
end
