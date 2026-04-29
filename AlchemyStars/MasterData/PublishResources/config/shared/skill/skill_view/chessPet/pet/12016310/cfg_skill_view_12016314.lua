local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayCasterAnimation,animName=Skill04; PlayCasterBindEffect,effectID =3468; PlayAudio,audioID = 2432; Wait,waitTime=6000; "
    },
    {"", "1,-1"}
  },
  {
    2,
    2,
    45,
    1,
    0,
    0,
    {
      prob = 30,
      tipsList = {12016314}
    }
  }
}
return config, "ID", key
