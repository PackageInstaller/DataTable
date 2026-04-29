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
      " PlayCasterAnimation,animName = Birth; PlaySummonTrap,trapID=40; PlayCasterVisible,visible=0; "
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
      effectIDList = {
        2412,
        2413,
        2414,
        2415
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID=2412; PlayCasterAddBuff, buffEffectType =2900263; "
    }
  }
}
return config, "ID", key
