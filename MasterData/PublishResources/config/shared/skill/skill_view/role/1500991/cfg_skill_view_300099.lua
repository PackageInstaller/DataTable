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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500991,waitTime = 2000; "
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
      " PlayCasterBindEffect,effectID =2373; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2260,audioType=1; Wait,waitTime=4000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2800,
    {
      "DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=4000991;"
    }
  }
}
return config, "ID", key
