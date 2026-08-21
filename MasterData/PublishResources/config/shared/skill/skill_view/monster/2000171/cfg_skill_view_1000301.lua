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
      "PlayEffectAtCasterPos, effectID=1495;"
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    300,
    {
      "PlayCasterVisible,visible=1;"
    }
  },
  {
    3,
    3,
    2,
    1,
    2,
    10,
    {
      effectparam = "134",
      castAnimationName = "Atk",
      finishDelayTime = 1000,
      buffDelayTime = 500
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    10,
    {
      "PlayCasterAddBuff, buffEffectType =3001;"
    }
  }
}
return config, "ID", key
