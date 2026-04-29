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
      " PlayCasterBindEffect,effectID=2457; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 2275,audioType=1; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    82,
    1,
    1,
    500,
    {
      radius = 1.8,
      high = 2.3,
      angle = 30,
      gridEffectID = 2458,
      flyEffectID = 2459,
      hitEffectID = 2460,
      waitFlyTime = 2250,
      flyTime = 100
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayCasterAddBuff, buffEffectType =410109; "
    }
  }
}
return config, "ID", key
