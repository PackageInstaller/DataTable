require("skill_phase_param_base")
_class("SkillPhaseFlotageTrajectoryParam", SkillPhaseParamBase)
SkillPhaseFlotageTrajectoryParam = SkillPhaseFlotageTrajectoryParam

function SkillPhaseFlotageTrajectoryParam:Constructor(t)
  self._efffectID = t.effectID
  self._spawnRadiusMin = t.spawnRadiusMin
  self._spawnRadiusMax = t.spawnRadiusMax
  self._offsetPosX = t.offsetPosX or 0
  self._offsetPosY = t.offsetPosY or 0
  self._offsetPosZ = t.offsetPosZ or 0
  self._firstPosX = t.firstPosX
  self._firstPosY = t.firstPosY
  self._firstPosZ = t.firstPosZ
  self._firstPosRandom = t.firstPosRandom
  self._spawnIntervalTime = t.spawnIntervalTime
  self._upSpeed = t.upSpeed
  local upShakeDisX = t.upShakeDisX
  local upShakeDisY = t.upShakeDisY
  local upShakeDisZ = t.upShakeDisZ
  self._upShakeDis = Vector3(upShakeDisX, upShakeDisY, upShakeDisZ)
  self._upShakeDertaTimeMin = t.upShakeDertaTimeMin
  self._upShakeDertaTimeMax = t.upShakeDertaTimeMax
  self._fireTimeMin = t.fireTimeMin
  self._fireTimeMax = t.fireTimeMax
  self._flyTime = t.flyTime
  self._flyRandomDis = t.flyRandomDis
  self._flyRandomPointCount = t.flyRandomPointCount
  self._destroyBulletDelay = t.destroyBulletDelay
  self._targetHit = t.targetHit
  self._targetHitOffsetMin = t.targetHitOffsetMin
  self._targetHitOffsetMax = t.targetHitOffsetMax
  self._turnToTarget = t.turnToTarget
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._hitPointDelay = t.hitPointDelay or 0
  self._fireEffectID = t.fireEffectID
  self._disableRoot = t.disableRoot
  self._summonTrapWithHit = t.summonTrapWithHit
  self._summonTrapEffectID = t.summonTrapEffectID
  self._summonTrapDirToTarget = t.summonTrapDirToTarget
  self._needLookAt = t.needLookAt
  self._hitSoundID = t.hitSoundID or 0
end

function SkillPhaseFlotageTrajectoryParam:GetCacheTable()
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

function SkillPhaseFlotageTrajectoryParam:GetPhaseType()
  return SkillViewPhaseType.FlotageTrajectory
end

function SkillPhaseFlotageTrajectoryParam:GetEffectID()
  return self._efffectID
end

function SkillPhaseFlotageTrajectoryParam:GetSpawnRadiusMin()
  return self._spawnRadiusMin
end

function SkillPhaseFlotageTrajectoryParam:GetSpawnRadiusMax()
  return self._spawnRadiusMax
end

function SkillPhaseFlotageTrajectoryParam:GetSpawnIntervalTime()
  return self._spawnIntervalTime
end

function SkillPhaseFlotageTrajectoryParam:GetSpawnOffsetPos()
  return Vector3(self._offsetPosX, self._offsetPosY, self._offsetPosZ)
end

function SkillPhaseFlotageTrajectoryParam:GetPathFirstPos()
  if not self._firstPosX then
    return nil
  end
  return Vector3(self._firstPosX, self._firstPosY, self._firstPosZ)
end

function SkillPhaseFlotageTrajectoryParam:GetFirstPosRandom()
  return self._firstPosRandom
end

function SkillPhaseFlotageTrajectoryParam:GetUpSpeed()
  return self._upSpeed
end

function SkillPhaseFlotageTrajectoryParam:GetUpShakeDis()
  return self._upShakeDis
end

function SkillPhaseFlotageTrajectoryParam:GetUpShakeDertaTimeMin()
  return self._upShakeDertaTimeMin
end

function SkillPhaseFlotageTrajectoryParam:GetUpShakeDertaTimeMax()
  return self._upShakeDertaTimeMax
end

function SkillPhaseFlotageTrajectoryParam:GetFireTimeMin()
  return self._fireTimeMin
end

function SkillPhaseFlotageTrajectoryParam:GetFireTimeMax()
  return self._fireTimeMax
end

function SkillPhaseFlotageTrajectoryParam:GetFlyTime()
  return self._flyTime
end

function SkillPhaseFlotageTrajectoryParam:GetFlyRandomDis()
  return self._flyRandomDis
end

function SkillPhaseFlotageTrajectoryParam:GetFlyRandomPointCount()
  return self._flyRandomPointCount
end

function SkillPhaseFlotageTrajectoryParam:GetdestroyBulletDelay()
  return self._destroyBulletDelay
end

function SkillPhaseFlotageTrajectoryParam:GetTargetHit()
  return self._targetHit
end

function SkillPhaseFlotageTrajectoryParam:GetTargetHitOffsetMin()
  return self._targetHitOffsetMin
end

function SkillPhaseFlotageTrajectoryParam:GetTargetHitOffsetMax()
  return self._targetHitOffsetMax
end

function SkillPhaseFlotageTrajectoryParam:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseFlotageTrajectoryParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseFlotageTrajectoryParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseFlotageTrajectoryParam:GetHitPointDelay()
  return self._hitPointDelay
end

function SkillPhaseFlotageTrajectoryParam:GetFireEffectID()
  return self._fireEffectID
end

function SkillPhaseFlotageTrajectoryParam:GetDisableRoot()
  return self._disableRoot
end

function SkillPhaseFlotageTrajectoryParam:GetSummonTrapWithHit()
  return self._summonTrapWithHit
end

function SkillPhaseFlotageTrajectoryParam:GetSummonTrapEffectID()
  return self._summonTrapEffectID
end

function SkillPhaseFlotageTrajectoryParam:GetSummonTrapDirToTarget()
  return self._summonTrapDirToTarget
end

function SkillPhaseFlotageTrajectoryParam:GetNeedLookAt()
  return self._needLookAt
end

function SkillPhaseFlotageTrajectoryParam:GetHitSoundID()
  return self._hitSoundID
end
