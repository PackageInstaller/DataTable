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
      effectparam = "134",
      castAnimationName = "Atk",
      finishDelayTime = 1000,
      buffDelayTime = 500
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2041, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterVisible, visible=1; "
    }
  }
}
return config, "ID", key
