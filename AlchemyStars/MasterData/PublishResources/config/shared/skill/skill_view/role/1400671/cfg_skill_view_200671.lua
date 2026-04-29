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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =2421; PlayCasterBindEffect,effectID =2426; PlayCasterBindEffect,effectID =2427; PlayAudio,audioID = 2291,audioType=1; Wait,waitTime=1130; PlayAddHpText; Wait,waitTime=1870; "
    }
  },
  {
    2,
    2,
    38,
    2,
    1,
    0,
    {
      effectIDList = {2426, 2427}
    }
  }
}
return config, "ID", key
