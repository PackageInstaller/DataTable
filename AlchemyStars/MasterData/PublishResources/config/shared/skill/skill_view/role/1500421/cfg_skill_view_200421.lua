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
      atkGridCenterEffectID = 1375,
      atkGridRandomEffect = {1376},
      centerDelay = 900,
      centerHitDelay = 900,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 2000
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
      "PlayAudio,audioID = 3032,audioType=1;"
    }
  }
}
return config, "ID", key
