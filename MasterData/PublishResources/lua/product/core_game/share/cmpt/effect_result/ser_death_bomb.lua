require("skill_effect_result_base")
_class("SkillEffectDeathBombResult", SkillEffectResultBase)
SkillEffectDeathBombResult = SkillEffectDeathBombResult

function SkillEffectDeathBombResult:Constructor(damageResults, bombScopeResult)
  self._damageResults = damageResults
  self._bombScopeResult = bombScopeResult
end

function SkillEffectDeathBombResult:GetEffectType()
  return SkillEffectType.DeathBomb
end

function SkillEffectDeathBombResult:GetDamageResults()
  return self._damageResults
end

function SkillEffectDeathBombResult:GetBombScopeResult()
  return self._bombScopeResult
end
