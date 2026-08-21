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
      " PlaySummonTrap,trapID=2800701; Wait,waitTime=1600; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=3621; PlayRideOn,rideOnDelay=100; PlayCasterBindEffect,effectID=3622; Wait,waitTime=100; "
    }
  }
}
return config, "ID", key
