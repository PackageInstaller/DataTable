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
      " PlayAudio,audioID = 290920103,audioType=1; PlayCasterAnimation,animName=Atk02; Wait,waitTime=567; PlayCasterBindEffect,effectID=290920101; PlayTeleportAsMoving,speed=33,stageIndex=1,moveUseResDir=1; Wait,waitTime=100; PlayCasterAnimation,animName=Atk02_2; Wait,waitTime=1500; "
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
      " PlayAudio,audioID = 290920103,audioType=1; PlayCasterBindEffect,effectID=290920101; PlayCasterAnimation,animName=Atk02; PlayTeleportAsMoving,speed=33,stageIndex=2,moveUseResDir=1; Wait,waitTime=100; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920112,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAnimation,animName=Atk02_2; "
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
      "DataSelectResult,effectType=5,index=1,damageStageIndex=1; PlayAddBuffView,buffID=29092006,label=doAgain1; PlayAddBuffView,buffID=20021; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=doAgain1; "
    }
  }
}
return config, "ID", key
