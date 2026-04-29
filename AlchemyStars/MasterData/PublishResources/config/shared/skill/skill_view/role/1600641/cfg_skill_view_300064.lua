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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600641,waitTime = 2000; "
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
      " PlayCasterBindEffect,effectID =1795; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2215,audioType=1; Wait,waitTime=3000; "
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
      "DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=3000641; PlayAddBuffView,buffID=3060641; PlayAddBuffView,buffID=3200641; PlayAddBuffView,buffID=3260641;"
    }
  }
}
return config, "ID", key
