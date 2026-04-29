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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID =1501571,waitTime =2000; "
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 2481,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =3699; PlayCasterBindEffect,effectID =3700; PlayCasterBindEffect,effectID =3701; PlayCasterBindEffect,effectID =3702; Wait,waitTime=666; PlayTrapAsMoving,time=100,summonOffset=0.5,moveAni=dash,moveEffID=3703,jumpAni=ult01,jumpEffID=0,jumpTime=166,fallAni=ult02,fallEffID=0,fallTime=2100; Wait,waitTime=1800; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    700,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3704,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1200,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType =4001571,label=doAgain; PlayTargetAddBuff,buffEffectType =300157; PlayTargetAddBuff,buffEffectType =310157; PlayTargetAddBuff,buffEffectType =320157; PlayTargetAddBuff,buffEffectType =330157; PlayTargetAddBuff,buffEffectType =302157; PlayTargetAddBuff,buffEffectType =312157; PlayTargetAddBuff,buffEffectType =322157; PlayTargetAddBuff,buffEffectType =332157; PlayTargetAddBuff,buffEffectType =305157; PlayTargetAddBuff,buffEffectType =315157; PlayTargetAddBuff,buffEffectType =325157; PlayTargetAddBuff,buffEffectType =335157; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
