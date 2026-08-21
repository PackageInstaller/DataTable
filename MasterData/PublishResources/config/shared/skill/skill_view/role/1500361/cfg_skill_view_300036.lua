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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500361,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " PlayCasterAnimation,animName = AtkUlt01; PlayCasterBindEffect,effectID=531; "
    },
    {"", "1,0"}
  },
  {
    3,
    3,
    38,
    1,
    1,
    2000,
    {
      effectIDList = {531}
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " PlayAudio,audioID = 2156,audioType=1; PlayCasterBindEffect,effectID=530; PlayCasterBindEffect,effectID=532; Wait,waitTime=3500; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=3014,label=doAgain; PlayTargetAddBuff,buffEffectType=3029; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
