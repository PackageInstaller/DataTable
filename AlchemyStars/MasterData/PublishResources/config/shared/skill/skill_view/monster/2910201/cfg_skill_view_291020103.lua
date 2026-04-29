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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName = skill1; PlayAudio,audioID = 29102012; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    500,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 291020101,flyTime = 250,flyTrace = 1,offsetx = 0.08,offsety = 0.94,offsety = 0.27,isBlock = 0,finalWaitTime=500,targetPos=Hit,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=250; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291020102,turnToTarget=1,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    5,
    {
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Wait,waitTime=10; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  }
}
return config, "ID", key
