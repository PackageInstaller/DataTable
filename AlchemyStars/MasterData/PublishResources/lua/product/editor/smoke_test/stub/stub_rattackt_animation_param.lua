if not SMOKE_TEST_ENABLED then
  return
end
Log.warn("TestRobotModule: SkillPhaseRangeAttackAnimationParam stub!")

function SkillPhaseRangeAttackAnimationParam:GetTrajectoryEffectID()
  if not self._trajectoryEffectID then
    return
  end
  if not Cfg.cfg_effect[self._trajectoryEffectID] then
    return
  end
  if Cfg.cfg_effect[self._trajectoryEffectID].Duration ~= -1 then
    Cfg.cfg_effect[self._trajectoryEffectID].Duration = -1
  end
  return self._trajectoryEffectID
end
