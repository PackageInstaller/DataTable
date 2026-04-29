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
      " PlayCasterBindEffect,effectID=1821; PlayAudio,audioID = 6055,audioType=1; Wait,waitTime=800; PlayCasterTurnToPlayer; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    45,
    1,
    1,
    3800,
    {
      prob = 100,
      tipsList = {290070101}
    }
  }
}
return config, "ID", key
