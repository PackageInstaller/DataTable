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
      " PlayCasterAnimation,animName = Skill04; PlayCasterBindEffect,effectID=2767; PlayCasterBindEffect,effectID=2768; PlayAudio,audioID = 6085,audioType=1; Wait,waitTime=4000; PlayModifyTimeScale,type=0; "
    }
  }
}
return config, "ID", key
