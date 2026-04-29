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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1601641,waitTime = 2000;"
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
      " PlayAudio,audioID = 2539; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=5000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2300,
    {
      " PlayCasterBindEffect,effectID = 3912; PlayCameraEffect,effectID = 3907; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2300,
    {
      " PlayOutlineByTransportDir,effectID =3910,radius=1; PlayOutlineByTransportGrid,effectID =3911,radius=1; PlayGridEffectByTransportGrid,effectID=3908,intrevalTime=100; Wait,waitTime=700; PlayTransportByRange; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2500,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    3000,
    {
      "DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; PlayGridRangeEffect,effectID=3909; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
