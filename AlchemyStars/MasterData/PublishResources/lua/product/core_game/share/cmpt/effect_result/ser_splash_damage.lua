require("skill_effect_result_base")
_class("SkillEffectSplashDamageResult", SkillEffectResultBase)
SkillEffectSplashDamageResult = SkillEffectSplashDamageResult

function SkillEffectSplashDamageResult:Constructor(damageResults, splashScopeResult, stageIndex)
  self._damageResults = damageResults
  self._splashScopeResult = splashScopeResult
  self._stageIndex = stageIndex
end

function SkillEffectSplashDamageResult:GetEffectType()
  return SkillEffectType.SplashDamage
end

function SkillEffectSplashDamageResult:GetDamageResults()
  return self._damageResults
end

function SkillEffectSplashDamageResult:GetSplashScopeResult()
  return self._splashScopeResult
end

function SkillEffectSplashDamageResult:GetDamageStageIndex()
  return self._stageIndex
end
