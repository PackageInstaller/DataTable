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
      " PlayEntityAnimation,animName=Skill01,monsterClassID=PARAM.ClassID; PlayEntityBindEffect,effectID=3280,monsterClassID=PARAM.ClassID; PlayAudio,audioID=6140,audioType=1; Wait,waitTime=3000; "
    }
  }
}
return config, "ID", key
