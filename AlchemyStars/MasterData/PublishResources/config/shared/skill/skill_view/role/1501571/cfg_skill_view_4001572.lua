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
      " PlayDeleteCasterEffect,effectIDList=3702; PlayAudio,audioID = 2483,audioType=1; PlayTrapAsMoving,time=100,summonOffset=0.5,moveAni=dash,moveEffID=3703,jumpAni=ult01,jumpEffID=0,jumpTime=166,fallAni=ult02,fallEffID=0,fallTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; Wait,waitTime=100; "
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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType =4101571,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
