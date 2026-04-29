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
      " PlayEffectAGridPos,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0,effectID=2526; "
    }
  }
}
return config, "ID", key
