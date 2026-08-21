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
      " PlayAudio,audioID = 290920103,audioType=1; PlayCasterAnimation,animName=Atk02; Wait,waitTime=567; PlayCasterBindEffect,effectID=290920101; PlayTeleportAsMoving,speed=33,stageIndex=1; Wait,waitTime=100; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920112,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
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
      " PlayTeleportAsMoving,speed=33,stageIndex=2; PlayCasterAnimation,animName=Atk02_2; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
