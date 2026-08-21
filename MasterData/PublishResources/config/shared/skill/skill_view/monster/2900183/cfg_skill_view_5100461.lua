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
      " PlayCasterAnimation,animName = Crazy; PlayCasterBindEffect,effectID=859; Wait,waitTime=500; PlayCasterChangeToMonster,monsterID=2900184; Wait,waitTime=500; PlayCasterBindEffect,effectID=860; PlayAudio,audioID=5050; Wait,waitTime=300; "
    }
  },
  {
    2,
    2,
    45,
    1,
    1,
    0,
    {
      prob = 100,
      tipsList = {290018101}
    }
  }
}
return config, "ID", key
