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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500131,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID=160201108; PlayCasterBindEffect,effectID=160201109; PlayAudio,audioID = 2648,audioType=1; Wait,waitTime=3800; "
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
      "DataSelectResult,effectType=85,index=1; PlayCostCasterHP;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2000,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,label=checkbuff2; PlayTargetAddBuff,buffEffectType =430201; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff2; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
