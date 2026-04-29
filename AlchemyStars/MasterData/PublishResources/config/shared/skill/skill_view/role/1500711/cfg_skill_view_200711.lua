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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2304,audioType=1; PlayCasterBindEffect,effectID=2512; PlayCasterBindEffect,effectID=2513; "
    }
  },
  {
    2,
    2,
    64,
    1,
    1,
    2600,
    {
      gridEffectID = 2514,
      intervalTime = 50,
      hitAnimName = "Hit",
      hitEffectID = 0,
      scopeHorizontalOrVertical = 1,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
