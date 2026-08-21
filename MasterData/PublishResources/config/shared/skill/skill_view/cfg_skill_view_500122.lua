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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID =588; Wait,waitTime=100; PlayCasterAddBuff, buffEffectType =3001; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6075, audioType = 1}
  }
}
return config, "ID", key
