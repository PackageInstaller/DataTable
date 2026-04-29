if not SMOKE_TEST_ENABLED then
  return
end
Log.warn("TestRobotModule: PlayFlyEffectCasterToTargetInstruction stub!")
local ctor = PlayFlyEffectCasterToTargetInstruction.Constructor

function PlayFlyEffectCasterToTargetInstruction:Constructor(...)
  ctor(self, ...)
  if not self._flyEffectID then
    return
  end
  if not Cfg.cfg_effect[self._flyEffectID] then
    return
  end
  if Cfg.cfg_effect[self._flyEffectID].Duration ~= -1 then
    Cfg.cfg_effect[self._flyEffectID].Duration = -1
  end
end
