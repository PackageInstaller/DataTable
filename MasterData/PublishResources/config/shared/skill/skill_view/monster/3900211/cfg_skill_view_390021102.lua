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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=670; Wait,waitTime=800; PlaySummonTrapBySummonEveryThing,trapID=2016; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5100, audioType = 1}
  }
}
return config, "ID", key
