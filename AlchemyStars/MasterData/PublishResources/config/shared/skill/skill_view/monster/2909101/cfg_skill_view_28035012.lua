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
    34,
    1,
    0,
    100,
    {
      gridEffectID = 0,
      gridEffectDelayTime = 500,
      gridIntervalTime = 0,
      showTimeDelay = 1000
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayGridPrism,prism=0,notPlayAnim=1; "
    }
  }
}
return config, "ID", key
