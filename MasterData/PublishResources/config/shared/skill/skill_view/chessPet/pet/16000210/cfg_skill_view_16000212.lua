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
      " PlayCasterBindEffect,effectID =493; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 2157,audioType=1; "
    }
  },
  {
    2,
    2,
    69,
    2,
    1,
    3000,
    {
      effectID = 494,
      hitEffectID = -1,
      hitAnimName = "Hit",
      intervalTime = 50,
      damageWaitTime = 2300
    }
  }
}
return config, "ID", key
