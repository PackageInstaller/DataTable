require("skill_effect_param_base")
_class("SkillEffectParamSnakeHeadMove", SkillEffectParamBase)
SkillEffectParamSnakeHeadMove = SkillEffectParamSnakeHeadMove

function SkillEffectParamSnakeHeadMove:Constructor(t)
  self._headMoveType = t.headMoveType
  self._tailMonsterID = t.tailMonsterID
end

function SkillEffectParamSnakeHeadMove:GetEffectType()
  return SkillEffectType.SnakeHeadMove
end

function SkillEffectParamSnakeHeadMove:GetHeadMoveType()
  return self._headMoveType
end

function SkillEffectParamSnakeHeadMove:GetTailMonsterID()
  return self._tailMonsterID
end

local SnakeMoveType = {
  Move = 1,
  Growth = 2,
  Attack = 3
}
_enum("SnakeMoveType", SnakeMoveType)
