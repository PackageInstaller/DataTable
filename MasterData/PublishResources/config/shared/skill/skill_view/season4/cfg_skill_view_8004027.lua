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
      effectparam = "1516,1517",
      castAnimationName = "Skill01",
      finishDelayTime = 0,
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
    {audioID = 2040, audioType = 1}
  },
  {
    3,
    3,
    0,
    2,
    1,
    600,
    {
      " PlaySummonTrap,trapID=8004023; PlaySummonTrap,trapID=8004024; "
    }
  }
}
return config, "ID", key
