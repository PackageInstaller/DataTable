require("skill_phase_param_base")
_class("SkillPhaseTrajectoryParam", SkillPhaseParamBase)
SkillPhaseTrajectoryParam = SkillPhaseTrajectoryParam

function SkillPhaseTrajectoryParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._ballHigh = t.ballHigh
  self._flyTime = t.flyTime
  self._flyRadius = t.flyRadius
  self._hideDistance = t.hideDistance
  self._upTime = t.upTime
end

function SkillPhaseTrajectoryParam:GetPhaseType()
  return SkillViewPhaseType.TrajectoryAnimation
end

function SkillPhaseTrajectoryParam:GetBallHigh()
  return self._ballHigh
end

function SkillPhaseTrajectoryParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseTrajectoryParam:FlyTime()
  return self._flyTime
end

function SkillPhaseTrajectoryParam:GetCameraAngle()
  return self._cameraAngle
end

function SkillPhaseTrajectoryParam:GetFlyRadius()
  return self._flyRadius
end

function SkillPhaseTrajectoryParam:GetHideDistance()
  return self._hideDistance
end

function SkillPhaseTrajectoryParam:GetUpTime()
  return self._upTime
end

function SkillPhaseTrajectoryParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    }
  }
  return t
end
