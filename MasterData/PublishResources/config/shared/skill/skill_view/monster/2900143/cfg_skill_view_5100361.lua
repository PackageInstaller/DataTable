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
      " PlayCasterAnimation,animName = Crazy; PlayMonsterStoryTips,prob=100,tipsList=(290014101); PlayCasterBindEffect,effectID=843; PlayAudio,audioID=5057; Wait,waitTime=1000; PlayCasterChangeToMonster,monsterID=2900144; Wait,waitTime=2200; "
    }
  }
}
return config, "ID", key
