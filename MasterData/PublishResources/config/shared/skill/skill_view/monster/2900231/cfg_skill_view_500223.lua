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
      " PlayCasterAnimation,animName = Skill; PlayCasterBindEffect,effectID =831; PlayMonsterStoryTips,prob=100,tipsList=(290023101); "
    }
  },
  {
    2,
    2,
    36,
    2,
    1,
    2200,
    {
      gridEffectID = 832,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      playerStepTime = 2800
    }
  },
  {
    3,
    3,
    43,
    1,
    0,
    0,
    {audioID = 5088, audioType = 1}
  }
}
return config, "ID", key
