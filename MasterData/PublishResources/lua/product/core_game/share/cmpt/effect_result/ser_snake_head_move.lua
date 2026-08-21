require("skill_effect_result_base")
_class("SkillEffectSnakeHeadMoveResult", SkillEffectResultBase)
SkillEffectSnakeHeadMoveResult = SkillEffectSnakeHeadMoveResult

function SkillEffectSnakeHeadMoveResult:Constructor(newPos, oldPos, casterIsDead, triggerTrapResult)
  self._newPos = newPos
  self._oldPos = oldPos
  self._casterIsDead = casterIsDead or false
  self._triggerTrapResult = triggerTrapResult or {}
end

function SkillEffectSnakeHeadMoveResult:Clone()
  local newResult = SkillEffectSnakeHeadMoveResult:New(self._newPos, self._oldPos, self._casterIsDead, self._triggerTrapResult)
  return newResult
end

function SkillEffectSnakeHeadMoveResult:GetTriggerTrapResult()
  return self._triggerTrapResult
end

function SkillEffectSnakeHeadMoveResult:GetEffectType()
  return SkillEffectType.SnakeHeadMove
end

function SkillEffectSnakeHeadMoveResult:GetNewPos()
  return self._newPos
end

function SkillEffectSnakeHeadMoveResult:GetOldPos()
  return self._oldPos
end

function SkillEffectSnakeHeadMoveResult:GetCasterIsDead()
  return self._casterIsDead
end

function SkillEffectSnakeHeadMoveResult:AddWalkTrap(trapEntityID, skillResult)
  local res = WalkTriggerTrapResult:New()
  res:SetTrapEntityID(trapEntityID)
  res:SetTrapResult(skillResult)
  self._triggerTrapResult[#self._triggerTrapResult + 1] = res
end
