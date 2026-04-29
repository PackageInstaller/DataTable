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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600601,waitTime = 2000; "
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
      " PlayCasterBindEffect,effectID =150203104; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2644,audioType=1; DataSelectResult,effectType=85,index=1; PlayCostCasterHP; Wait,waitTime=6500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1000,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =4002032; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; "
    }
  }
}
return config, "ID", key
