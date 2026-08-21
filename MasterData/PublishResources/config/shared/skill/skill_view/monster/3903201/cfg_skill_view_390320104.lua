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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=430; Wait,waitTime=2200; PlaySummonMeantimeLimit,trapDieSkillID=390320115,forceMeanTime=1; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6155, audioType = 1}
  }
}
return config, "ID", key
