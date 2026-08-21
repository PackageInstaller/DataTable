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
      "PlayAudio,audioID =150235102,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =150235103; Wait,waitTime = 3000; "
    }
  },
  {
    2,
    2,
    7,
    1,
    1,
    550,
    {
      gridEffectID = 0,
      columnInternalTime = 0,
      hitAnimName = "Hit",
      hitEffectID = 150235104,
      gridEffectWaitTime = 0,
      hitWaitTime = 0
    }
  }
}
return config, "ID", key
