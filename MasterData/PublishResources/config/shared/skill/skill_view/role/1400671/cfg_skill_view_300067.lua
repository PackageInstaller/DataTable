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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1400671,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterBindEffect,effectID =2425; PlayCasterBindEffect,effectID =2426; PlayCasterBindEffect,effectID =2427; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2292,audioType=1; Wait,waitTime=3000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2000,
    {
      " PlayTeamBindEffect,effectID=2422,mode=1; "
    }
  },
  {
    4,
    4,
    38,
    2,
    2,
    0,
    {
      effectIDList = {2426, 2427}
    }
  }
}
return config, "ID", key
