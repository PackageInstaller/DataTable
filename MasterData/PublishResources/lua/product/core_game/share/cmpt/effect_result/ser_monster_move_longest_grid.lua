require("skill_effect_result_base")
_class("SkillEffectMonsterMoveLongestGridResult", SkillEffectResultBase)
SkillEffectMonsterMoveLongestGridResult = SkillEffectMonsterMoveLongestGridResult

function SkillEffectMonsterMoveLongestGridResult:GetEffectType()
  return SkillEffectType.MonsterMoveLongestGrid
end

function SkillEffectMonsterMoveLongestGridResult:Constructor(walkResultList, isDead, finalAttackResult, summonTrapResult)
  self._walkResultList = walkResultList
  self._isDead = isDead
  self._summonTrapResultList = summonTrapResult
  self._finalAttackResult = finalAttackResult
end

function SkillEffectMonsterMoveLongestGridResult:GetWalkResultList()
  return self._walkResultList
end

function SkillEffectMonsterMoveLongestGridResult:IsCasterDead()
  return self._isDead
end

function SkillEffectMonsterMoveLongestGridResult:GetFinalAttackResult()
  return self._finalAttackResult
end

function SkillEffectMonsterMoveLongestGridResult:GetSummonTrapResultList()
  return self._summonTrapResultList
end

_class("MonsterMoveLongestGridResult", MonsterWalkResult)
MonsterMoveLongestGridResult = MonsterMoveLongestGridResult

function MonsterMoveLongestGridResult:Constructor()
  self._newPieceType = nil
  self._attackResult = nil
  self._flushTrapID = nil
end

function MonsterMoveLongestGridResult:SetNewGridType(pieceType)
  self._newPieceType = pieceType
end

function MonsterMoveLongestGridResult:SetAttackResult(attackResult)
  self._attackResult = attackResult
end

function MonsterMoveLongestGridResult:SetFlushTrapID(trapID)
  self._flushTrapID = trapID
end

function MonsterMoveLongestGridResult:GetNewGridType()
  return self._newPieceType
end

function MonsterMoveLongestGridResult:GetAttackResult()
  return self._attackResult
end

function MonsterMoveLongestGridResult:GetFlushTrapID()
  return self._flushTrapID
end
