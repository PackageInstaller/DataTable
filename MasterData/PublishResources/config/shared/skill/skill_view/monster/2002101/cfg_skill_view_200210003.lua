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
      " PlaySummonTrap,trapID=PARAM.trapID1; PlayCasterAnimation,animName=Disappear; Wait,waitTime=1000; PlayRoleTeleport,type=3; PlayRoleTeleport,type=5,onlySelf=0; PlayRoleTeleport,type=6; PlayRoleTeleport,type=9; "
    }
  },
  {
    2,
    2,
    38,
    1,
    0,
    0,
    {
      effectIDList = {3281}
    }
  }
}
return config, "ID", key
