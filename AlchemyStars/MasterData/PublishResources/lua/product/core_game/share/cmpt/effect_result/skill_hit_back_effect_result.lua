_class("SkillHitBackEffectResult", SkillEffectResultBase)
SkillHitBackEffectResult = SkillHitBackEffectResult

function SkillHitBackEffectResult:Constructor(targetId, startPos, targetPos, gridElementChangeTable, calcType, hitDir, colorNew)
  self._effectType = SkillEffectType.HitBack
  self._targetId = targetId
  self._startPos = startPos
  self._targetPos = targetPos
  self._gridElementChangeTable = gridElementChangeTable
  self._hitbackCalcType = calcType
  self._hitDir = hitDir
  self._colorNew = colorNew
  self._hadPlay = false
  self._isBlocked = false
  self._blockMonsterID = nil
end

function SkillHitBackEffectResult:GetEffectType()
  return SkillEffectType.HitBack
end

function SkillHitBackEffectResult:GetStartPos()
  return self._startPos
end

function SkillHitBackEffectResult:GetGridPos()
  return self._targetPos
end

function SkillHitBackEffectResult:GetPosTarget()
  return self._targetPos
end

function SkillHitBackEffectResult:GetHitDir()
  return self._hitDir
end

function SkillHitBackEffectResult:ClearHitDir()
  self._hitDir = nil
end

function SkillHitBackEffectResult:IsHaveMoveDir()
  local dirMove = self._targetPos - self._startPos
  return dirMove.x ~= 0 or dirMove.y ~= 0
end

function SkillHitBackEffectResult:GetGridElementChangeTable()
  return self._gridElementChangeTable
end

function SkillHitBackEffectResult:GetCalcType()
  return self._hitbackCalcType
end

function SkillHitBackEffectResult:GetTargetID()
  return self._targetId
end

function SkillHitBackEffectResult:SetTriggerTrapIds(triggerTraps)
  self._triggerTraps = triggerTraps
end

function SkillHitBackEffectResult:GetTriggerTrapIds()
  return self._triggerTraps
end

function SkillHitBackEffectResult:GetColorNew()
  return self._colorNew
end

function SkillHitBackEffectResult:GetHadPlay()
  return self._hadPlay
end

function SkillHitBackEffectResult:SetHadPlay(hadPlay)
  self._hadPlay = hadPlay
end

function SkillHitBackEffectResult:SetBombTrapEntityID(bombTrapEntity)
  self._bombTrapEntityID = bombTrapEntity
end

function SkillHitBackEffectResult:GetBombTrapEntityID()
  return self._bombTrapEntityID
end

function SkillHitBackEffectResult:SetIsBlocked(isBlocked)
  self._isBlocked = isBlocked
end

function SkillHitBackEffectResult:GetIsBlocked()
  return self._isBlocked
end

function SkillHitBackEffectResult:SetBlockMonsterID(monsterID)
  self._blockMonsterID = monsterID
end

function SkillHitBackEffectResult:GetBlockMonsterID()
  return self._blockMonsterID
end
