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
      " PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 160218102,audioType=1; PlayCasterBindEffect,effectID =160218103; PlayCasterBindEffect,effectID =160218104,scaleByBuffValueKey=layerCount410218,scaleByBuffValueParam=0.35 ; Wait,waitTime=4000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1300,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayAudio,audioID = 160218103,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=160218105,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
