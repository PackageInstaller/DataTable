require("skill_phase_param_base")
_class("SkillPhaseControlMonsterMoveAttackSummonParam", SkillPhaseParamBase)
SkillPhaseControlMonsterMoveAttackSummonParam = SkillPhaseControlMonsterMoveAttackSummonParam

function SkillPhaseControlMonsterMoveAttackSummonParam:Constructor(t)
  self._stageIndex = t.stageIndex
  self._teleportStartWaitTime = t.teleportStartWaitTime
  self._teleportAnim = t.teleportAnim
  self._teleportTime = t.teleportTime
  self._teleportFinishAnim = t.teleportFinishAnim
  self._teleportFinishWaitTime = t.teleportFinishWaitTime
  self._jumpEffectID = t.jumpEffectID
  self._moveSpeed = t.moveSpeed
  self._flyOneTime = t.flyOneTime
  self._turnToTarget = t.turnToTarget
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._moveEffectID = t.moveEffectID
  self._moveAnim = t.moveAnim
  self._cacheEffectCount = t.cacheEffectCount or 5
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetCacheTable()
  local t = {}
  if self._moveEffectID and self._moveEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._moveEffectID].ResPath,
      self._cacheEffectCount
    })
  end
  if self._jumpEffectID and 0 < self._jumpEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._jumpEffectID].ResPath,
      self._cacheEffectCount
    })
  end
  return t
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetStageIndex()
  return self._stageIndex
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetTeleportStartWaitTime()
  return self._teleportStartWaitTime
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetTeleportAnim()
  return self._teleportAnim
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetTeleportTime()
  return self._teleportTime
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetTeleportFinishAnim()
  return self._teleportFinishAnim
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetTeleportFinishWaitTime()
  return self._teleportFinishWaitTime
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetJumpEffectID()
  return self._jumpEffectID
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetMoveSpeed()
  return self._moveSpeed
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetFlyOneTime()
  return self._flyOneTime
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetMoveEffectID()
  return self._moveEffectID
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetMoveAnim()
  return self._moveAnim
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetPhaseType()
  return SkillViewPhaseType.ControlMonsterMoveAttackSummon
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseControlMonsterMoveAttackSummonParam:GetHitEffectID()
  return self._hitEffectID
end
