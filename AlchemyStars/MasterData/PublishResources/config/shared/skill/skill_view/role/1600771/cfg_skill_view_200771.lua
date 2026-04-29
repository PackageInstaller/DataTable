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
    66,
    1,
    0,
    0,
    {
      atkAnim = "AtkChain",
      atkGridCenterEffectID = 1084,
      atkGridRandomEffect = {1085, 1086},
      centerHitDelay = 1900,
      centerDelay = 1966,
      otherGridHitDelay = 0,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 2500
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
      "PlayAudio,audioID = 3002,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      "DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=3002; "
    }
  }
}
return config, "ID", key
