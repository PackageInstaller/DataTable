require("skill_effect_result_base")
_class("SkillEffectMonsterMoveFrontAttackResult", SkillEffectResultBase)
SkillEffectMonsterMoveFrontAttackResult = SkillEffectMonsterMoveFrontAttackResult

function SkillEffectMonsterMoveFrontAttackResult:GetEffectType()
  return SkillEffectType.MonsterMoveFrontAttack
end

function SkillEffectMonsterMoveFrontAttackResult:Constructor(walkResultList, isDead)
  self._walkResultList = walkResultList
  self._isDead = isDead
end

function SkillEffectMonsterMoveFrontAttackResult:GetWalkResultList()
  return self._walkResultList
end

function SkillEffectMonsterMoveFrontAttackResult:IsCasterDead()
  return self._isDead
end

_class("MonsterMoveFrontAttackResult", MonsterWalkResult)
MonsterMoveFrontAttackResult = MonsterMoveFrontAttackResult

function MonsterMoveFrontAttackResult:Constructor()
end
