require("skill_effect_param_base")
_class("SkillEffectParamSnakeTailMove", SkillEffectParamBase)
SkillEffectParamSnakeTailMove = SkillEffectParamSnakeTailMove

function SkillEffectParamSnakeTailMove:Constructor(t)
  self._moveType = t.moveType
  self._bodyMonsterID = t.bodyMonsterID
end

function SkillEffectParamSnakeTailMove:GetEffectType()
  return SkillEffectType.SnakeTailMove
end

function SkillEffectParamSnakeTailMove:GetMoveType()
  return self._moveType
end

function SkillEffectParamSnakeTailMove:GetBodyMonsterID()
  return self._bodyMonsterID
end
