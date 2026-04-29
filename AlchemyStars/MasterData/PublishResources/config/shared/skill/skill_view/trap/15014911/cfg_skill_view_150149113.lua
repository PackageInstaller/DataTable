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
      " PlayAudio,audioID = 2447,audioType=1; PlayCasterAnimation,animName = atkult_01; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    30,
    1,
    1,
    0,
    {
      gridEffectID = 3496,
      bestEffectTime = 1500,
      finishDelayTime = 1000
    }
  }
}
return config, "ID", key
