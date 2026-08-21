require("skill_effect_result_base")
_class("SkillEffectSnakeBodyMoveAndGrowthResult", SkillEffectResultBase)
SkillEffectSnakeBodyMoveAndGrowthResult = SkillEffectSnakeBodyMoveAndGrowthResult

function SkillEffectSnakeBodyMoveAndGrowthResult:Constructor(bodyOldPos, bodyNewPos, oldBodyArea, newBodyArea, newBodyPos)
  self._bodyNewPos = bodyNewPos
  self._bodyOldPos = bodyOldPos
  self._oldBodyArea = oldBodyArea
  self._newBodyArea = newBodyArea
  self._newBodyPos = newBodyPos
  self._casterIsDead = false
  self._headNewPos = nil
end

function SkillEffectSnakeBodyMoveAndGrowthResult:Clone()
  local result = SkillEffectSnakeBodyMoveAndGrowthResult:New(self._bodyOldPos, self._bodyNewPos, self._oldBodyArea, self._newBodyArea, self._newBodyPos)
  result._casterIsDead = self._casterIsDead
  return result
end

function SkillEffectSnakeBodyMoveAndGrowthResult:IsCasterDead()
  return self._casterIsDead
end

function SkillEffectSnakeBodyMoveAndGrowthResult:SetCasterDeadState(state)
  self._casterIsDead = state
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetEffectType()
  return SkillEffectType.SnakeBodyMoveAndGrowth
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetBodyNewPos()
  return self._bodyNewPos
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetBodyOldPos()
  return self._bodyOldPos
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetOldBodyArea()
  return self._oldBodyArea
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetNewBodyArea()
  return self._newBodyArea
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetNewBodyPos()
  return self._newBodyPos
end

function SkillEffectSnakeBodyMoveAndGrowthResult:SetHeadNewPos(pos)
  self._headNewPos = pos
end

function SkillEffectSnakeBodyMoveAndGrowthResult:GetHeadNewPos()
  return self._headNewPos
end
