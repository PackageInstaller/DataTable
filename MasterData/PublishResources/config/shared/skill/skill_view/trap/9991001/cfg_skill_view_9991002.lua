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
      " PlayMonsterStoryTips,prob=100,tipsList=(9991002); PlayCasterAnimation,animName =Death; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
