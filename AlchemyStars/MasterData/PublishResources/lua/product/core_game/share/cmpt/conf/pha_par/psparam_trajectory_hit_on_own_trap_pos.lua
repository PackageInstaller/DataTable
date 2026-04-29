require("skill_phase_param_base")
_class("SkillPhaseTrajectoryHitOnOwnTrapPosParam", SkillPhaseParamBase)
SkillPhaseTrajectoryHitOnOwnTrapPosParam = SkillPhaseTrajectoryHitOnOwnTrapPosParam

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:Constructor(t)
  self._hitAnim = t.hitAnim
  self._hitDelayTime = t.hitDelayTime
  self._hitEffectID = t.hitEffectID
  self._casterAnim = t.casterAnim
  self._casterEffectID = t.casterEffectID
  self._bulletStartDelay = t.bulletStartDelay
  self._bulletEffectID = t.bulletEffectID
  self._bulletBeginBindBone = t.bulletBeginBindBone
  self._bulletEndBindBone = t.bulletEndBindBone
  self._bulletFlyTotalTime = t.bulletFlyTotalTime
  self._totalTime = t.totalTime
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetPhaseType()
  return SkillViewPhaseType.TrajectoryHitOnOwnTrapPos
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetCasterAnim()
  return self._casterAnim
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetCasterEffectID()
  return self._casterEffectID
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetBulletStartDelay()
  return self._bulletStartDelay
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetBulletEffectID()
  return self._bulletEffectID
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetBulletBeginBindBone()
  return self._bulletBeginBindBone
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetBulletEndBindBone()
  return self._bulletEndBindBone
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetBulletFlyTotalTime()
  return self._bulletFlyTotalTime
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetHitAnim()
  return self._hitAnim
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetHitDelayTime()
  return self._hitDelayTime
end

function SkillPhaseTrajectoryHitOnOwnTrapPosParam:GetTotalTime()
  return self._totalTime
end
