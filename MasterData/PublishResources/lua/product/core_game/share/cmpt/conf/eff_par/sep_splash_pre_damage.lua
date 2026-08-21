require("skill_damage_effect_param")
local SkillSplashCenterType = {Target = 1, Caster = 2}
_enum("SkillSplashCenterType", SkillSplashCenterType)
_class("SkillEffectParamSplashPreDamage", SkillDamageEffectParam)
SkillEffectParamSplashPreDamage = SkillEffectParamSplashPreDamage

function SkillEffectParamSplashPreDamage:Constructor(t)
  self._splashRate = t.splashRate
  self._splashScopeType = t.splashScopeType
  self._splashScopeParam = t.splashScopeParam
  self._baseDamageStageIndex = t.baseDamageStageIndex or 1
  self._splashCenterType = t.splashCenterType or SkillSplashCenterType.Target
end

function SkillEffectParamSplashPreDamage:GetEffectType()
  return SkillEffectType.SplashPreDamage
end

function SkillEffectParamSplashPreDamage:GetSplashRate()
  return self._splashRate
end

function SkillEffectParamSplashPreDamage:GetSplashScopeType()
  return self._splashScopeType
end

function SkillEffectParamSplashPreDamage:GetSplashScopeParam()
  return self._splashScopeParam
end

function SkillEffectParamSplashPreDamage:GetBaseDamageStageIndex()
  return self._baseDamageStageIndex
end

function SkillEffectParamSplashPreDamage:GetSplashCenterType()
  return self._splashCenterType
end
