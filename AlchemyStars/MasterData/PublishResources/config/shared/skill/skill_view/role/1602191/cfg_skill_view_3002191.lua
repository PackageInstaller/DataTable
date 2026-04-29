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
      " PlayAudio,audioID = 160219106,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=160219101; PlayCasterBindEffect,effectID=160219102; Wait,waitTime=1300; PlayCameraEffect,effectID=160219103; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=40021911,label=doAgain; PlayCasterAddBuff,buffEffectType=40021913; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=3000; "
    }
  }
}
return config, "ID", key
