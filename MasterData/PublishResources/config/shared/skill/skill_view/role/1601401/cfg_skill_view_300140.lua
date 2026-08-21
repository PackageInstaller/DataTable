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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601401,waitTime = 2000; "
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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2403,audioType=1; PlayCasterBindEffect,effectID=3340; PlayCasterBindEffect,effectID=3342; PlayCameraEffect,effectID=3341; Wait,waitTime=3500; "
    }
  },
  {
    3,
    4,
    0,
    2,
    1,
    1700,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=3014,label=doAgain; PlayTargetAddBuff,buffEffectType=3029; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
