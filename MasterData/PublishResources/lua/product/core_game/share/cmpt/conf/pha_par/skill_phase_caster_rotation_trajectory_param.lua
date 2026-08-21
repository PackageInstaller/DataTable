require("skill_phase_param_base")
_class("SkillPhaseCasterRotationTrajectoryParam", SkillPhaseParamBase)
SkillPhaseCasterRotationTrajectoryParam = SkillPhaseCasterRotationTrajectoryParam

function SkillPhaseCasterRotationTrajectoryParam:Constructor(t)
  self._effectID = t.effectID
  self._fireEffectID = t.fireEffectID
  self._spawnHigh = t.spawnHigh
  self._spawnRadius = t.spawnRadius
  self._rotationTime = t.rotationTime
  self._flyOneTime = t.flyOneTime
  self._destroyBulletDelay = t.destroyBulletDelay
  self._disableRoot = t.disableRoot
  self._turnToTarget = t.turnToTarget
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._cacheEffectCount = t.cacheEffectCount or 1
end

function SkillPhaseCasterRotationTrajectoryParam:GetCacheTable()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      self._cacheEffectCount
    })
  end
  if self._fireEffectID and 0 < self._fireEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._fireEffectID].ResPath,
      self._cacheEffectCount
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      self._cacheEffectCount
    })
  end
  return t
end

function SkillPhaseCasterRotationTrajectoryParam:GetPhaseType()
  return SkillViewPhaseType.CasterRotationTrajectory
end

function SkillPhaseCasterRotationTrajectoryParam:GetEffectID()
  return self._effectID
end

function SkillPhaseCasterRotationTrajectoryParam:GetFireEffectID()
  return self._fireEffectID
end

function SkillPhaseCasterRotationTrajectoryParam:GetSpawnHigh()
  return self._spawnHigh
end

function SkillPhaseCasterRotationTrajectoryParam:GetSpawnRadius()
  return self._spawnRadius
end

function SkillPhaseCasterRotationTrajectoryParam:GetRotationTime()
  return self._rotationTime
end

function SkillPhaseCasterRotationTrajectoryParam:GetFlyOneTime()
  return self._flyOneTime
end

function SkillPhaseCasterRotationTrajectoryParam:GetdestroyBulletDelay()
  return self._destroyBulletDelay
end

function SkillPhaseCasterRotationTrajectoryParam:GetDisableRoot()
  return self._disableRoot
end

function SkillPhaseCasterRotationTrajectoryParam:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseCasterRotationTrajectoryParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseCasterRotationTrajectoryParam:GetHitEffectID()
  return self._hitEffectID
end
