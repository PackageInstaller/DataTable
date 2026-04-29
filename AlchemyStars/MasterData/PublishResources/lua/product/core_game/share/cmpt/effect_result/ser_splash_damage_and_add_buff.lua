require("skill_effect_result_base")
_class("SkillEffectSplashDamageAndAddBuffResult", SkillEffectResultBase)
SkillEffectSplashDamageAndAddBuffResult = SkillEffectSplashDamageAndAddBuffResult

function SkillEffectSplashDamageAndAddBuffResult:Constructor(centerPos, damageResults, buffResults)
  self._centerPos = centerPos
  self._damageResults = damageResults
  self._buffResults = buffResults
end

function SkillEffectSplashDamageAndAddBuffResult:GetEffectType()
  return SkillEffectType.SplashDamageAndAddBuff
end

function SkillEffectSplashDamageAndAddBuffResult:GetCenterPos()
  return self._centerPos
end

function SkillEffectSplashDamageAndAddBuffResult:GetDamageResults()
  return self._damageResults
end

function SkillEffectSplashDamageAndAddBuffResult:GetBuffResults()
  return self._buffResults
end
