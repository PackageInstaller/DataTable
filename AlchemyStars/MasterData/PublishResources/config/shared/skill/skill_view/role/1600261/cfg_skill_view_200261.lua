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
      effectparam = "476",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 0
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
      "PlayAudio,audioID = 2183,audioType=1;"
    }
  },
  {
    3,
    3,
    70,
    1,
    1,
    1050,
    {
      gridDelayTime = 200,
      gridEffectID = 477,
      gridIntervalTime = 200,
      hitPointDelay = 200,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = -1,
      finishDelayTime = 0
    }
  },
  {
    4,
    4,
    0,
    1,
    3,
    0,
    {
      " PlayTargetAddBuff,buffID=20011; "
    }
  }
}
return config, "ID", key
