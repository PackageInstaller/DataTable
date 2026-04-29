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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2218,audioType=1; Wait,waitTime=500; PlayEffectAtCasterPos, effectID=1847; Wait,waitTime=500; PlayCasterBindEffect,effectID=1848; Wait,waitTime=1000; PlayCasterBindEffect,effectID=1851; Wait,waitTime=1500; "
    }
  },
  {
    2,
    2,
    16,
    1,
    1,
    2000,
    {
      hitEffectID = 1853,
      hitAnimName = "Hit",
      flyEffectID = 1849,
      flyBackEffectID = 1850,
      flyTime = 400,
      flyBackTime = 400,
      flyArriveDestory = 300,
      flyBackStartWaitTime = 200
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    800,
    {
      " PlayCasterBindEffect,effectID = 1852; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
