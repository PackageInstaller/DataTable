require("skill_effect_result_base")
_class("SkillEffectResultSummonWithCasterAttribute", SkillEffectResultBase)
SkillEffectResultSummonWithCasterAttribute = SkillEffectResultSummonWithCasterAttribute

function SkillEffectResultSummonWithCasterAttribute:Constructor(entityID)
  self._entityID = entityID
end

function SkillEffectResultSummonWithCasterAttribute:GetEffectType()
  return SkillEffectType.SummonWithCasterAttribute
end

function SkillEffectResultSummonWithCasterAttribute:GetEntityID()
  return self._entityID
end
