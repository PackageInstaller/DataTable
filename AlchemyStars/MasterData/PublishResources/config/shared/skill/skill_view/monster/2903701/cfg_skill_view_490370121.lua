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
      " PlayCasterAnimation,animName=skill02; PlayCasterBindEffect,effectID=290370101; Wait,waitTime=650; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290370102,turnToTarget=1,deathClear=0; PlayAudio,audioID=6214,audioType=1; Wait,waitTime=1050; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=490371202,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
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
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; "
    }
  }
}
return config, "ID", key
