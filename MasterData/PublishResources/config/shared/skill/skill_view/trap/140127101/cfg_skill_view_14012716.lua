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
      " PlayDeleteCasterEffect,effectIDList=2794; PlayGridVisible,visible=1; "
    }
  },
  {
    2,
    2,
    30,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      bestEffectTime = 1500,
      finishDelayTime = 1000
    }
  }
}
return config, "ID", key
