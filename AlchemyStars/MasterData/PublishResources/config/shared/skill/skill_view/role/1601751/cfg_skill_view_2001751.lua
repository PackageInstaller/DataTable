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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2553,audioType=1; PlayCasterBindEffect,effectID =160175103; PlayCasterBindEffect,effectID =160175104; PlayCasterBindEffect,effectID =160175105; Wait,waitTime=1500; PlayAddHpText; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
