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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600061,waitTime = 2000;"
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
      " PlayCasterBindEffect,effectID = 160206105; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2669,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    800,
    {
      "PlayCameraEffect,effectID=160206109; PlayEffectAtPickUpIndexGrid,effectID=160206106,pickUpIndex=1; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    800,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; PlayEffectOffsetScopeCenter,effectID=160206107,offset=0|0; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160206108,label=playRangeEffect; PlayGridRangeEffect,effectID=160206111; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSortScopeGridRange,sortType=6; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=160206110; DataSelectScopeGridRangeLast; PlayGridRangeEffect,effectID=160206110,offset=0|1; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    3030,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    3030,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=18; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=160206104; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
