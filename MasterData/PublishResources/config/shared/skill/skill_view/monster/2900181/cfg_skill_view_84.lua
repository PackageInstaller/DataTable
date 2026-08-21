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
      " PlayCasterAnimation,animName = Crazy; PlayCasterBindEffect,effectID=859; Wait,waitTime=1000; PlayCasterBindEffect,effectID=860; PlayAudio,audioID=5045; PlayAddHpText; Wait,waitTime=1300; PlayCasterChangeToMonster,monsterID=2900182; "
    }
  }
}
return config, "ID", key
