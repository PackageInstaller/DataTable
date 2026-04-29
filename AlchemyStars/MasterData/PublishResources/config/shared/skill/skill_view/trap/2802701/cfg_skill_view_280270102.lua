local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " PlayFixTrapWall,stageIndex=1; Wait,waitTime=400; PlayFixTrapWall,stageIndex=2; "
    }
  }
}
return config, "ID", key
