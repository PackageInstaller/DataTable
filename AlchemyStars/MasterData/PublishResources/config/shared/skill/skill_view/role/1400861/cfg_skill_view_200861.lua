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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =1743; PlayAudio,audioID = 3078,audioType=1; Wait,waitTime=1300; PlayAddHpText; Wait,waitTime=3500; "
    }
  }
}
return config, "ID", key
