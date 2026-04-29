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
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterBindEffect,effectID =493; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2157,audioType=1; "
    },
    {"", "1,0"}
  },
  {
    2,
    3,
    69,
    1,
    0,
    3000,
    {
      effectID = 494,
      hitEffectID = -1,
      hitAnimName = "Hit",
      intervalTime = 50,
      damageWaitTime = 2300
    }
  },
  {
    3,
    4,
    30,
    1,
    0,
    5000,
    {
      gridEffectID = 321,
      bestEffectTime = 500,
      finishDelayTime = 1000
    }
  },
  {
    4,
    5,
    23,
    2,
    3,
    0,
    {showTime = 0}
  }
}
return config, "ID", key
