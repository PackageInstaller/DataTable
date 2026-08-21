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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1108; PlayAudio,audioID = 3027,audioType=1; Wait,waitTime=2600; PlayAddHpText; Wait,waitTime=1900; "
    }
  }
}
return config, "ID", key
