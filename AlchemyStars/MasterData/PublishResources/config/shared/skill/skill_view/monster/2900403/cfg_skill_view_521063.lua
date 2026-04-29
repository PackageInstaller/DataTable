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
      " PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID = 6039,audioType=1; Wait,waitTime=1500; PlayAddHpText; "
    }
  }
}
return config, "ID", key
