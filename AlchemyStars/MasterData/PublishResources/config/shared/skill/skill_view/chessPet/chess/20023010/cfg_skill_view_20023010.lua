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
    2,
    1,
    0,
    0,
    {
      effectparam = "200230101",
      castAnimationName = "Skill01",
      finishDelayTime = 1800,
      buffDelayTime = 0
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
      " PlayCasterBindEffect,effectID=200230103; PlayCasterBindEffect,effectID=200230104; "
    }
  },
  {
    3,
    3,
    43,
    1,
    1,
    0,
    {audioID = 7041, audioType = 1}
  },
  {
    4,
    4,
    36,
    1,
    1,
    1200,
    {
      gridEffectID = 200230102,
      gridEffectDelayTime = 0,
      gridIntervalTime = 10,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
