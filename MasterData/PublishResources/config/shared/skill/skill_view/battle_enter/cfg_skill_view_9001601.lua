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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=3725; "
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
      " BattleEnterPets; "
    }
  }
}
return config, "ID", key
