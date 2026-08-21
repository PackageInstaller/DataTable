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
      " DataSelectResult,effectType=117,index=1; PlaySummonMeantimeLimit,trapDieSkillID=150149112,forceMeanTime=1; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
