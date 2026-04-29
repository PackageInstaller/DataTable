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
    2,
    1,
    0,
    0,
    {
      effectparam = "759",
      castAnimationName = "Shield",
      finishDelayTime = 3666,
      buffDelayTime = 1000
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      "PlayCasterAddBuff, buffEffectType =3001; PlayAudio,audioID = 5074,audioType=1;"
    }
  }
}
return config, "ID", key
