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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1601881,waitTime = 2000; "
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
      " PlayGridDark,darkType=0; PlayCameraEffect,effectID =160188107; PlayEffectAGridPos,effectID=160188108,gridPosX=5,gridPosY=5; PlaySelectObjAnimation,objName=eff_1601881_atkult_main,animName=eff_1601881_atkult_main_in; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 160188104,audioType=1; "
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
      " DataSelectScopeGridRangePickUp,pickUpIndex=1; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=160188110,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayAudio,audioID = 160188105,audioType=1; Wait,waitTime=1000; PlayGridRangeConvert,dataSource=4,label=playRangeEffect;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2400,
    {
      " DataSelectScopeGridRangePickUp,pickUpIndex=2; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeEffect,effectID=160188111,label=playRangeEffect; PlayAudio,audioID = 160188105,audioType=1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayGridRangeConvert,dataSource=4,label=playRangeEffect;"
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    4000,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=16; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160188109,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; "
    }
  },
  {
    6,
    6,
    0,
    2,
    5,
    0,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=demage3; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=demage3;"
    }
  },
  {
    7,
    7,
    0,
    2,
    5,
    0,
    {
      " PlayCameraEffect,effectID =160188107; PlaySelectObjAnimation,objName=eff_1601881_atkult_gezi_one,animName=eff_1601881_atkult_gezi_one_out; PlaySelectObjAnimation,objName=eff_1601881_atkult_gezi_two,animName=eff_1601881_atkult_gezi_two_out; PlaySelectObjAnimation,objName=eff_1601881_atkult_main,animName=eff_1601881_atkult_main_out; Wait,waitTime=1500; PlayGridDark,darkType=1; "
    }
  }
}
return config, "ID", key
