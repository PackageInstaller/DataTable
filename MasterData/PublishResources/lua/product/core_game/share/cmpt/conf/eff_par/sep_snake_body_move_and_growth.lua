require("skill_effect_param_base")
_class("SkillEffectParamSnakeBodyMoveAndGrowth", SkillEffectParamBase)
SkillEffectParamSnakeBodyMoveAndGrowth = SkillEffectParamSnakeBodyMoveAndGrowth

function SkillEffectParamSnakeBodyMoveAndGrowth:Constructor(t)
  self._moveType = t.moveType
  self._headMonsterID = t.headMonsterID
end

function SkillEffectParamSnakeBodyMoveAndGrowth:GetEffectType()
  return SkillEffectType.SnakeBodyMoveAndGrowth
end

function SkillEffectParamSnakeBodyMoveAndGrowth:GetMoveType()
  return self._moveType
end

function SkillEffectParamSnakeBodyMoveAndGrowth:GetHeadMonsterID()
  return self._headMonsterID
end
