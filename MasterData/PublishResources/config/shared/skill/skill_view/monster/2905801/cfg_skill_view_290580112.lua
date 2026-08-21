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
      " PlayCasterAnimation,animName=Atk2; PlayAudio,audioID =290580103,audioType=1; PlayCasterBindEffect,effectID=290580104; Wait,waitTime=3200; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    570,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 290580105,flyTime=200,flyTrace = 1,offsetx=-0.134,offsety=1.529,offsetz=0.33,targetPos=Root ; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290580106,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=5361005,label=doAgain; PlayTargetAddBuff,buffID=5361006; PlayTargetAddBuff,buffID=29058014; PlayTargetAddBuff,buffID=29058013; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
