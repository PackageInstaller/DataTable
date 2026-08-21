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
    0,
    0,
    0,
    {
      " PlayCasterVisible,visible=1; PlayAudio,audioID = 6049,audioType=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=1883; PlayCasterBindEffect,effectID=1884; PlayCasterBindEffect,effectID=1885; Wait,waitTime=5666; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterAddBuff,buffID=30241; "
    }
  }
}
return config, "ID", key
