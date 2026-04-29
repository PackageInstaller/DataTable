require("skill_phase_param_base")
_class("SkillPhaseSphereTrajectoryMultiStageDamageParam", SkillPhaseParamBase)
SkillPhaseSphereTrajectoryMultiStageDamageParam = SkillPhaseSphereTrajectoryMultiStageDamageParam

function SkillPhaseSphereTrajectoryMultiStageDamageParam:Constructor(t)
  self._eftID = t.effectID
  self._trajectoryCount = t.trajectoryCount
  self._sphereRadius = t.sphereRadius or 5
  self._startWait = t.startWait or 0
  self._moveSpeed = t.moveSpeed
  self._rotateSpeed = t.rotateSpeed
  self._turnToTarget = t.turnToTarget
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._hitSoundID = t.hitSoundID or 0
  self._intervalTime = t.intervalTime or 300
  self._random = t.random or 0
  self._randomPercent = t.randomPercent or 10
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetCacheTable()
  local t = {}
  if self._eftID and self._eftID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._eftID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetPhaseType()
  return SkillViewPhaseType.SphereTrajectoryMultiStageDamage
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetEftID()
  return self._eftID
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetTrajectoryCount()
  return self._trajectoryCount
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetSphereRadius()
  return self._sphereRadius
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetStartWait()
  return self._startWait
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetMoveSpeed()
  return self._moveSpeed
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetRotateSpeed()
  return self._rotateSpeed
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetHitSoundID()
  return self._hitSoundID
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetIntervalTime()
  return self._intervalTime
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetRandom()
  return self._random
end

function SkillPhaseSphereTrajectoryMultiStageDamageParam:GetRandomPercent()
  return self._randomPercent
end
