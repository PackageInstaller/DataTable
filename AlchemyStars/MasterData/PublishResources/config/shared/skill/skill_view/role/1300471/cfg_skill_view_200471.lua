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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =471; PlayAudio,audioID = 2096,audioType=1; Wait,waitTime=1180; PlayAddHpText; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
