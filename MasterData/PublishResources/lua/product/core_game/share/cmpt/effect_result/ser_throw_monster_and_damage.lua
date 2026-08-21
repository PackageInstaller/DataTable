require("skill_effect_result_base")
_class("SkillEffectThrowMonsterAndDamageResult", SkillEffectResultBase)
SkillEffectThrowMonsterAndDamageResult = SkillEffectThrowMonsterAndDamageResult

function SkillEffectThrowMonsterAndDamageResult:Constructor(monsterEntityIDs, damageRes)
  self._monsterEntityIDs = monsterEntityIDs
  self._damageResult = damageRes
end

function SkillEffectThrowMonsterAndDamageResult:GetEffectType()
  return SkillEffectType.ThrowMonsterAndDamage
end

function SkillEffectThrowMonsterAndDamageResult:GetMonsterEntityIDs()
  return self._monsterEntityIDs
end

function SkillEffectThrowMonsterAndDamageResult:GetDamageResult()
  return self._damageResult
end
