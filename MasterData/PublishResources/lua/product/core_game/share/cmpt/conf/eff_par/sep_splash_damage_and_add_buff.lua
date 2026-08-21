require("skill_damage_effect_param")
_class("SkillEffectParamSplashDamageAndAddBuff", SkillDamageEffectParam)
SkillEffectParamSplashDamageAndAddBuff = SkillEffectParamSplashDamageAndAddBuff

function SkillEffectParamSplashDamageAndAddBuff:Constructor(t)
  self._splashTargetType = t.splashTargetType
  self._splashScopeType = t.splashScopeType
  self._splashScopeParam = t.splashScopeParam
  self._splashOffset = t.splashOffset
  self._buffID = t.buffID
end

function SkillEffectParamSplashDamageAndAddBuff:GetEffectType()
  return SkillEffectType.SplashDamageAndAddBuff
end

function SkillEffectParamSplashDamageAndAddBuff:GetSplashTargetType()
  return self._splashTargetType
end

function SkillEffectParamSplashDamageAndAddBuff:GetSplashScopeType()
  return self._splashScopeType
end

function SkillEffectParamSplashDamageAndAddBuff:GetSplashScopeParam()
  return self._splashScopeParam
end

function SkillEffectParamSplashDamageAndAddBuff:GetSplashOffset()
  return self._splashOffset
end

function SkillEffectParamSplashDamageAndAddBuff:GetBuffID()
  return self._buffID
end
