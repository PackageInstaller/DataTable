require("skill_effect_result_base")
_class("SkillEffectResultAddMonsterWeak", SkillEffectResultBase)
SkillEffectResultAddMonsterWeak = SkillEffectResultAddMonsterWeak

function SkillEffectResultAddMonsterWeak:Constructor(entityID, weakResult, damageResult)
  self._entityID = entityID
  self._weakResult = weakResult
  self._damageResult = damageResult
end

function SkillEffectResultAddMonsterWeak:GetEffectType()
  return SkillEffectType.AddMonsterWeak
end

function SkillEffectResultAddMonsterWeak:GetEntityID()
  return self._entityID
end

function SkillEffectResultAddMonsterWeak:GetWeakResult()
  return self._weakResult
end

function SkillEffectResultAddMonsterWeak:GetDamageResult()
  return self._damageResult
end
