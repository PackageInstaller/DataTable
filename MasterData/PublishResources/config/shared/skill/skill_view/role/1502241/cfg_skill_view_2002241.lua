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
      " PlayEntityAnimation,animName = AtkChain,petTemplateID=1502241; PlayEntityBindEffect,effectID =150224106,petTemplateID=1502241; PlayAudio,audioID = 150224102; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1800,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayEntityTurnToTarget,petTemplateID=1502241,label=doAgain; PlayMultiJumpEffectToTarget,usePetTemplateID=1502241,useTargetViewDamageCenter=1,flyEffectID=150224107,flyTime=500,startOffsetX=0,startOffsetY=2.15,startOffsetZ=0,targetOffsetX=0,targetOffsetZ=0,jumpPower=1.6; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=150224108,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2500,
    {
      " DataSelectResult,effectType=80,index=1,damageStageIndex=2; PlaySelectedSplashDamage,hitAnimName=Hit,hitEffectID=0,turnToTarget=true,gridEffectID=-1,label=splashAgain; DataSelectNextResult,effectType=80,damageStageIndex=2; Wait,waitTime=380; Jump,condition=CheckEffectResultIndex,param=80,goto=splashAgain; "
    }
  }
}
return config, "ID", key
