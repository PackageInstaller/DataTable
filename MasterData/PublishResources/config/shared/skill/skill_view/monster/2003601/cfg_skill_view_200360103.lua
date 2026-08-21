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
      " PlayAudio,audioID =7016,audioType=1; PlayCasterAnimation,animName = Death01; Wait,waitTime=500; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=500; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName = Birth01; PlayCasterBindEffect,effectID=200360103; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=200360105; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
