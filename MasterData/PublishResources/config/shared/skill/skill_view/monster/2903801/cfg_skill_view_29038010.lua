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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayAudio,audioID=6219,audioType=1; PlayCasterAddBuff,buffID=29038011; Wait,waitTime=200; PlayCasterBindEffect,effectID=290380101; Wait,waitTime=2500; PlayCasterBindEffect,effectID=290380102; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
