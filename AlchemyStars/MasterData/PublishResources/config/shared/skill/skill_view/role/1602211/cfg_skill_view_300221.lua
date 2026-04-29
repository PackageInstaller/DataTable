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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1602211,waitTime = 2000;"
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
      " PlayAudio,audioID = 160221104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =160221107; Wait,waitTime=250; PlayCameraEffect,effectID =160221104; Wait,waitTime=550; PlayEffectAtPickUpIndexGrid,effectID=160221105,pickUpIndex=1; PlaySummonTrap,trapID=2803501; Wait,waitTime=4800; PlayCasterBindEffect,effectID =160221108; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2600,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160221106,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2600,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=4002211,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    4500,
    {
      " DataSelectScopeGridRangePickUp,pickUpIndex=1; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; "
    }
  }
}
return config, "ID", key
