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
      " PlayAudio,audioID = 2178,audioType=1; "
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
      " PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=3000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      "PlayCasterBindEffect,effectID=433; PlayCasterBindEffect,effectID=435;"
    }
  },
  {
    4,
    4,
    78,
    1,
    1,
    1600,
    {
      effectID = 434,
      intervalTime = 100,
      effectScale = 1.3,
      downDisance = -50,
      waitDownTime = 2666,
      downTime = 100,
      waitTime = 933,
      upTime = 100,
      waitDamageTime = 66,
      hitEffectID = 0,
      hitAnimName = "Hit"
    }
  }
}
return config, "ID", key
