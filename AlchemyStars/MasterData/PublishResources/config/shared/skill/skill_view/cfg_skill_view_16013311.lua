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
      " PlayCasterAnimation,animName = AtkChain1; PlayCasterBindEffect,effectID =3232; PlayAudio,audioID = 2388; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterTurnToTarget,label=doAgain; PlayFlyEffectCasterToTarget,flyEffectID=3234,flyTime=200,flyTrace=1,offsety=1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3235,turnToTarget=1,deathClear=0; PlayCasterBindEffect,effectID =3233; PlayAudio,audioID = 2389; Wait,waitTime=100; PlayCasterAnimation,animName = AtkChain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAnimation,animName = AtkChain3; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,label=playConvert; PlayGridRangeEffect,effectID=480; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playConvert; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
