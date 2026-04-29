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
      " PlayCasterBindEffect,effectID =2425; PlayCasterBindEffect,effectID =2426; PlayCasterBindEffect,effectID =2427; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2292,audioType=1; Wait,waitTime=3000; "
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
      " PlayTeamBindEffect,effectID=2422,mode=1; PlayAddHpText; "
    }
  },
  {
    3,
    3,
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
