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
      " PlayCasterBindEffect,effectID=661; Wait,waitTime=1100; PlayTransformation; PlayCasterAnimation,animName =Skill03_trans; PlayAudio,audioID = 5024,audioType=1; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
