require("skill_phase_param_base")
_class("SkillPhaseCircularTrajectoryParam", SkillPhaseParamBase)
SkillPhaseCircularTrajectoryParam = SkillPhaseCircularTrajectoryParam

function SkillPhaseCircularTrajectoryParam:Constructor(t)
  self._efffectID = t.effectID
  self._spawnCenterBone = t.spawnCenterBone
  self._spawnRadiusMin = t.spawnRadiusMin
  self._spawnRadiusMax = t.spawnRadiusMax
  self._spawnIntervalTime = t.spawnIntervalTime
  self._waitFireTime = t.waitFireTime
  self._flyTime = t.flyTime
  self._destroyBulletDelay = t.destroyBulletDelay
  self._targetHit = t.targetHit
  self._turnToTarget = t.turnToTarget
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._oneArrowOffsetX = t.oneArrowOffsetX or 0
  self._oneArrowOffsetY = t.oneArrowOffsetY or 0
  self._oneArrowOffsetZ = t.oneArrowOffsetZ or 0
end

function SkillPhaseCircularTrajectoryParam:GetCacheTable()
  local t = {}
  if self._efffectID and self._efffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._efffectID].ResPath,
      5
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      5
    })
  end
  return t
end

function SkillPhaseCircularTrajectoryParam:GetPhaseType()
  return SkillViewPhaseType.CircularTrajectory
end

function SkillPhaseCircularTrajectoryParam:GetEffectID()
  return self._efffectID
end

function SkillPhaseCircularTrajectoryParam:GetSpawnCenterBone()
  return self._spawnCenterBone
end

function SkillPhaseCircularTrajectoryParam:GetSpawnRadiusMin()
  return self._spawnRadiusMin
end

function SkillPhaseCircularTrajectoryParam:GetSpawnRadiusMax()
  return self._spawnRadiusMax
end

function SkillPhaseCircularTrajectoryParam:GetSpawnIntervalTime()
  return self._spawnIntervalTime
end

function SkillPhaseCircularTrajectoryParam:GetWaitFireTime()
  return self._waitFireTime
end

function SkillPhaseCircularTrajectoryParam:GetFlyTime()
  return self._flyTime
end

function SkillPhaseCircularTrajectoryParam:GetdestroyBulletDelay()
  return self._destroyBulletDelay
end

function SkillPhaseCircularTrajectoryParam:GetTargetHit()
  return self._targetHit
end

function SkillPhaseCircularTrajectoryParam:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseCircularTrajectoryParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseCircularTrajectoryParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseCircularTrajectoryParam:GetOneArrowOffset()
  return Vector3(self._oneArrowOffsetX, self._oneArrowOffsetY, self._oneArrowOffsetZ)
end
