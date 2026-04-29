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
      effectparam = "200270102",
      castAnimationName = "Atk",
      finishDelayTime = 2000,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 7059, audioType = 1}
  },
  {
    3,
    3,
    36,
    1,
    1,
    462,
    {
      gridEffectID = 200270101,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    462,
    {
      "PlayRecoverFromGreyHP;"
    }
  }
}
return config, "ID", key
