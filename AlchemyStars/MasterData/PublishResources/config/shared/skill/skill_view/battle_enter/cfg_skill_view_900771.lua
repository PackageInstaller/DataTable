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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=1880; PlayCasterBindEffect,effectID=1881; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    500,
    {
      " BattleEnterPets,effLightPillar=1879,petShowDelay=400,interval=150|150|150; "
    }
  }
}
return config, "ID", key
