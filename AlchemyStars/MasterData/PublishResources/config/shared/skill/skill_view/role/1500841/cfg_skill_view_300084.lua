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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500841,waitTime = 2000;"
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1804; PlayAudio,audioID = 3098,audioType=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=3014,label=doAgain; PlayTargetAddBuff,buffEffectType=3029; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=5000; "
    }
  }
}
return config, "ID", key
