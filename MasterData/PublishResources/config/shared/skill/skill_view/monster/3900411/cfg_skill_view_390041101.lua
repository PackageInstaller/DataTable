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
      " PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 6015,audioType=1; PlayCasterBindEffect,effectID=1286; PlayCasterBindEffect,effectID=1294; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    2800,
    {
      gridEffectID = 1290,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 20
    }
  }
}
return config, "ID", key
