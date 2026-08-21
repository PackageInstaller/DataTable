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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601551,waitTime = 2000;"
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
      " PlayAudio,audioID = 160177404,audioType=1; PlayCasterBindEffect,effectID =160177311; PlayCasterAnimation,animName = AtkUlt; PlayEffectAGridPos,effectID=160177312,gridPosX=5,gridPosY=4; PlayCasterBindEffect,effectID =160177110; PlayCasterBindEffect,effectID =160177310; PlayCameraEffect, effectID=160177313; PlayUIEffectOutside, effectName=eff_1601773_atkult_ui,duration=6000; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =330177; PlayTargetAddBuff,buffEffectType =30017703; PlayTargetAddBuff,buffEffectType =3001773; PlayTargetAddBuff,buffEffectType =33017713; PlayTargetAddBuff,buffEffectType =3001770; PlayTargetAddBuff,buffEffectType =300177; PlayTargetAddBuff,buffEffectType =330177; PlayTargetAddBuff,buffEffectType =3301771; PlayTargetAddBuff,buffEffectType =3001777; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; Wait,waitTime=8000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    500,
    {
      " UiHudVisible,visible=0; UiBattleVisible,visible=0,time=1000; Wait,waitTime=5200; UiHudVisible,visible=1; UiBattleVisible,visible=1,time=500; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    4600,
    {
      " DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=160177302,label=playRangeEffect; PlaySummonTrap,trapID=14; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
