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
    30,
    1,
    0,
    0,
    {
      gridEffectID = 3367,
      bestEffectTime = 0,
      finishDelayTime = 0,
      notifyPreview = 1
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 2417,audioType=1; "
    }
  }
}
return config, "ID", key
