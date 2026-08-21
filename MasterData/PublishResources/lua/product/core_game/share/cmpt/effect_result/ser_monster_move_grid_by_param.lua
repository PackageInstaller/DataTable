require("skill_effect_result_base")
_class("SkillEffectMonsterMoveGridByParamResult", SkillEffectResultBase)
SkillEffectMonsterMoveGridByParamResult = SkillEffectMonsterMoveGridByParamResult

function SkillEffectMonsterMoveGridByParamResult:Constructor(walkResultList, isDead)
  self._walkResultList = walkResultList
  self._isDead = isDead
end

function SkillEffectMonsterMoveGridByParamResult:GetEffectType()
  return SkillEffectType.MonsterMoveGridByParam
end

function SkillEffectMonsterMoveGridByParamResult:GetWalkResultList()
  return self._walkResultList
end

function SkillEffectMonsterMoveGridByParamResult:IsCasterDead()
  return self._isDead
end

_class("MoveGridByParamResult", MonsterWalkResult)
MoveGridByParamResult = MoveGridByParamResult

function MoveGridByParamResult:Constructor()
  self._newPieceType = nil
  self._attackResult = nil
end

function MoveGridByParamResult:SetNewGridType(pieceType)
  self._newPieceType = pieceType
end

function MoveGridByParamResult:SetAttackResult(attackResult)
  self._attackResult = attackResult
end

function MoveGridByParamResult:GetNewGridType()
  return self._newPieceType
end

function MoveGridByParamResult:GetAttackResult()
  return self._attackResult
end
