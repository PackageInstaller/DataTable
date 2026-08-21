require("skill_effect_param_base")
_class("SkillAbsorbPieceEffectParam", SkillEffectParamBase)
SkillAbsorbPieceEffectParam = SkillAbsorbPieceEffectParam

function SkillAbsorbPieceEffectParam:Constructor(t)
  self._pieceType = t.pieceType
  self._pieceCount = t.pieceCount
end

function SkillAbsorbPieceEffectParam:GetEffectType()
  return SkillEffectType.AbsorbPiece
end

function SkillAbsorbPieceEffectParam:GetPieceType()
  return self._pieceType
end

function SkillAbsorbPieceEffectParam:GetPieceCount()
  return self._pieceCount
end
