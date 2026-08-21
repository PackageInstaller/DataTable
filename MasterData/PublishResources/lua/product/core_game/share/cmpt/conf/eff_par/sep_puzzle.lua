require("skill_effect_param_base")
_class("SkillEffectPuzzleParam", SkillEffectParamBase)
SkillEffectPuzzleParam = SkillEffectPuzzleParam

function SkillEffectPuzzleParam:Constructor(t)
  self._convertPieceType = t.convertPieceType
end

function SkillEffectPuzzleParam:GetEffectType()
  return SkillEffectType.Puzzle
end

function SkillEffectPuzzleParam:GetConvertPieceType()
  return self._convertPieceType
end
