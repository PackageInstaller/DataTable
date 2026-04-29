require("skill_effect_result_base")
_class("SkillEffectResultDetonateMonsterWeak", SkillEffectResultBase)
SkillEffectResultDetonateMonsterWeak = SkillEffectResultDetonateMonsterWeak

function SkillEffectResultDetonateMonsterWeak:Constructor(entityID, weakResults, damageResults, damageCenters)
  self._entityID = entityID
  self._weakResult = weakResults
  self._damageResult = damageResults
  self._damageCenters = damageCenters
end

function SkillEffectResultDetonateMonsterWeak:GetEffectType()
  return SkillEffectType.DetonateMonsterWeak
end

function SkillEffectResultDetonateMonsterWeak:GetEntityID()
  return self._entityID
end

function SkillEffectResultDetonateMonsterWeak:GetWeakResult()
  return self._weakResult
end

function SkillEffectResultDetonateMonsterWeak:GetDamageResult()
  return self._damageResult
end

function SkillEffectResultDetonateMonsterWeak:GetDamageCenters()
  return self._damageCenters
end
