require("skill_effect_result_base")
_class("SkillEffectSnakeTailMoveResult", SkillEffectResultBase)
SkillEffectSnakeTailMoveResult = SkillEffectSnakeTailMoveResult

function SkillEffectSnakeTailMoveResult:Constructor(newPos, casterIsDead)
  self._newPos = newPos
  self._triggerTrapResult = {}
  self._casterIsDead = casterIsDead or false
  self._triggerTrapResult = {}
  self._lastBodyPos = nil
end

function SkillEffectSnakeTailMoveResult:SetLastBodyPos(pos)
  self._lastBodyPos = pos
end

function SkillEffectSnakeTailMoveResult:GetLastBodyPos()
  return self._lastBodyPos
end

function SkillEffectSnakeTailMoveResult:IsCasterDead()
  return self._casterIsDead
end

function SkillEffectSnakeTailMoveResult:GetTriggerTrapResult()
  return self._triggerTrapResult
end

function SkillEffectSnakeTailMoveResult:SetCasterDeadState(state)
  self._casterIsDead = state
end

function SkillEffectSnakeTailMoveResult:GetEffectType()
  return SkillEffectType.SnakeTailMove
end

function SkillEffectSnakeTailMoveResult:GetNewPos()
  return self._newPos
end

function SkillEffectSnakeTailMoveResult:AddWalkTrap(trapEntityID, skillResult)
  local res = WalkTriggerTrapResult:New()
  res:SetTrapEntityID(trapEntityID)
  res:SetTrapResult(skillResult)
  self._trapResultList[#self._trapResultList + 1] = res
end
