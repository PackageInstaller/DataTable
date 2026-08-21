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
      " Wait,waitTime=200; PlayCasterAnimation,animName = Skill0301; PlayAudio,audioID = 6058,audioType=1; PlayCasterBindEffect,effectID =1835; PlayCasterBindEffect,effectID =1836; Wait,waitTime=2500; PlayCasterAnimation,animName = Skill0302; "
    }
  },
  {
    2,
    2,
    45,
    1,
    1,
    0,
    {
      prob = 100,
      tipsList = {290070102}
    }
  }
}
return config, "ID", key
