require("skill_effect_result_base")
_class("SkillAbsorbPieceEffectResult", SkillEffectResultBase)
SkillAbsorbPieceEffectResult = SkillAbsorbPieceEffectResult

function SkillAbsorbPieceEffectResult:Constructor()
  self._targetAbsorbPieceList = {}
  self._newPieceList = {}
end

function SkillAbsorbPieceEffectResult:GetEffectType()
  return SkillEffectType.AbsorbPiece
end

function SkillAbsorbPieceEffectResult:GetAbsorbPieceList()
  return self._targetAbsorbPieceList
end

function SkillAbsorbPieceEffectResult:SetAbsorbPieceList(pieceList)
  self._targetAbsorbPieceList = pieceList
end

function SkillAbsorbPieceEffectResult:SetNewPieceList(newPieceList)
  self._newPieceList = newPieceList
end

function SkillAbsorbPieceEffectResult:GetNewPieceList()
  return self._newPieceList
end
