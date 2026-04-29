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
      " PlayCacheRes,petID=1502131,effectIDs=150213106|150213107|150213108|150213109|150213111"
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
      " PlayCasterAnimation,animName=AtkUlt; PlayCasterVisible,visible=1; PlayCasterBindEffect,effectID = 150213112; PlayAudio,audioID = 150213104; Wait,waitTime=800; PlayPuzzle,gridEffectID=150213110; "
    }
  }
}
return config, "ID", key
