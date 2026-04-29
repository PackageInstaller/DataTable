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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1600101,waitTime = 2000;"
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
      " PlayAudio,audioID = 2166,audioType=1; PlayShowLineRenderer,show=0,selfAll=1; PlayMonsterVisible,visible=0; PlayTrapVisible,visible=0; UiHudVisible,visible=0; PlayCasterAnimation,animName = AtkUlt1; Wait,waitTime=966; PlayEffectAtCasterPos, effectID=37600; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID=376; PlayCasterBindEffect,effectID=377; Wait,waitTime=6000; PlayTrapVisible,visible=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=30141,label=doAgain; PlayTargetAddBuff,buffID=30142; PlayTargetAddBuff,buffID=30143; PlayTargetAddBuff,buffID=30144; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; PlayMonsterVisible,visible=1; UiHudVisible,visible=1; PlayShowLineRenderer,show=1,selfAll=1; "
    },
    {"6,4", "1,-1"}
  }
}
return config, "ID", key
