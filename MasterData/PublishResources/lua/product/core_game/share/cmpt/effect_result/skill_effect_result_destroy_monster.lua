require("skill_effect_result_base")
_class("SkillEffectDestroyMonsterResult", SkillEffectResultBase)
SkillEffectDestroyMonsterResult = SkillEffectDestroyMonsterResult

function SkillEffectDestroyMonsterResult:GetEffectType()
  return SkillEffectType.DestroyMonster
end

function SkillEffectDestroyMonsterResult:Constructor(entityID)
  self.entityID = entityID
end

function SkillEffectDestroyMonsterResult:GetEntityID()
  return self.entityID
end
