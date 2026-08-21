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
      " PlayEffectAGridPos,effectID=2551,gridPosX=5,gridPosY=3,gridDirX=0,gridDirY=0; Wait,waitTime=1500; PlayTransport; Wait,waitTime=50; "
    }
  }
}
return config, "ID", key
