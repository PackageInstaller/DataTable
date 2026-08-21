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
      " PlayCasterBindEffect,effectID =2373; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2260,audioType=1; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      "DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=24000991;"
    }
  },
  {
    3,
    3,
    0,
    3,
    2,
    0,
    {
      " PlayCasterBindEffect,effectID =2371; PlayAudio,audioID = 2259; "
    }
  },
  {
    4,
    4,
    66,
    3,
    3,
    0,
    {
      atkAnim = "AtkChain",
      atkGridCenterEffectID = 2372,
      atkGridRandomEffect = {2370},
      centerHitDelay = 1050,
      centerDelay = 1050,
      otherGridHitDelay = 0,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 2500,
      distanceDelay = 50
    }
  }
}
return config, "ID", key
