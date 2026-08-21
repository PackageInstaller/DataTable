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
    100,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=16016610; "
    }
  }
}
return config, "ID", key
