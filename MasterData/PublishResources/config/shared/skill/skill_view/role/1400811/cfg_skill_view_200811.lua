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
      atkGridCenterEffectID = 1758,
      atkGridRandomEffect = {1759},
      centerHitDelay = 1300,
      centerDelay = 0,
      otherGridHitDelay = 1300,
      hitAnim = "Hit",
      hitEffectID = 1780,
      finishDelayTime = 3000
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      "PlayAudio,audioID = 3073,audioType=1;"
    }
  }
}
return config, "ID", key
