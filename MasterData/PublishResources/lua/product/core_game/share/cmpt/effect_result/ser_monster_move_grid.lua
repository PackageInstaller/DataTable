require("skill_effect_result_base")
_class("SkillEffectMonsterMoveGridResult", SkillEffectResultBase)
SkillEffectMonsterMoveGridResult = SkillEffectMonsterMoveGridResult

function SkillEffectMonsterMoveGridResult:GetEffectType()
  return SkillEffectType.MonsterMoveGrid
end

function SkillEffectMonsterMoveGridResult:Constructor(walkResultList, isDead)
  self._walkResultList = walkResultList
  self._isDead = isDead
end

function SkillEffectMonsterMoveGridResult:GetWalkResultList()
  return self._walkResultList
end

function SkillEffectMonsterMoveGridResult:IsCasterDead()
  return self._isDeadss
end

_class("MonsterMoveGridResult", MonsterWalkResult)
MonsterMoveGridResult = MonsterMoveGridResult

function MonsterMoveGridResult:Constructor()
  self._newPieceType = nil
end

function MonsterMoveGridResult:SetNewGridType(pieceType)
  self._newPieceType = pieceType
end

function MonsterMoveGridResult:GetNewGridType()
  return self._newPieceType
end
