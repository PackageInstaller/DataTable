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
      " PlayCasterBindEffect,effectID =160201105; PlayCasterBindEffect,effectID =160201106; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2647,audioType=1; PlayEffectAGridPos,effectID=160201111,gridPosX=5,gridPosY=4; PlayCameraEffect, effectID=160201110; Wait,waitTime=1800; PlayCasterAddBuff,buffID=531400511; PlayCasterMaterialAnim,animName=common_shield; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,label=checkbuff; PlayTargetAddBuff,buffEffectType =400201; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; Wait,waitTime=1300; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1800,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,label=checkbuff2; PlayTargetAddBuff,buffEffectType =531400511; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff2; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
