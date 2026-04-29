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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600251,waitTime = 2000;"
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
      " PlayEffectAGridPos,effectID=160025404,gridPosX=5,gridPosY=5; PlayAudio,audioID = 2551,audioType=1; PlayCasterBindEffect,effectID=160025402; Wait,waitTime=2000; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; Wait,waitTime=4500; PlayEffectByTrainDir, effectID=160025403; Wait,waitTime=2700; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    250,
    {
      " PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=8950; PlayCasterAnimation,animName=AtkUlt1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1200,
    {
      " PlayTrainEffect, effectID=160025401; Wait,waitTime=3100; PlayTrainAttack, AttackCount=10, OneDamageTime=33, RandomPercent=10; Wait,waitTime=1000; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3100,
    {
      " DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,isRotate=1,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
