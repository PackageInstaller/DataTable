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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1602181,waitTime = 2000;"
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
      " PlayAudio,audioID = 160218104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=160218310; Wait,waitTime=500; PlayEffectAGridPos,effectID=160218308,gridPosX=5,gridPosY=4; Wait,waitTime=300; PlayCasterVisible,visible=0; PlayCameraEffect,effectID =160218306; Wait,waitTime=200; PlayEffectAtPickUpIndexGrid,effectID=160218307,pickUpIndex=1; Wait,waitTime=1800; PlayCasterVisible,visible=1; PlayEffectAtCasterPos, effectID=160218309; Wait,waitTime=1800; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2800,
    {
      " DataSelectScopeGridRangePickUp,pickUpIndex=1; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; PlaySummonTrap,trapID=2803501;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2800,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2800,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=4402183,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  }
}
return config, "ID", key
