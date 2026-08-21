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
      " PlayCasterAnimation,animName=Absorb; PlayAudio,audioID = 7013,audioType=1; PlayAbsorbPieceEffect,flyEffectID=PARAM.effectID1,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=150,targetPos=Hit,waitFlyEffectTime=800; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayCasterAnimation,animName=Atk; PlayAudio,audioID = 7012,audioType=1; Wait,waitTime=400; Jump,condition=CheckAbsortPieceCountLessThan,param=3,goto=effect1; Jump,condition=CheckTrue,goto=pieceCount1; PlayCasterBindEffect,effectID=PARAM.effectID3,label=effect1; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=PARAM.effectID4,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType=InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID5,turnToTarget=1,deathClear=0; Jump,condition=CheckTrue,goto=phaseEnd; Jump,condition=CheckAbsortPieceCountLessThan,param=6,goto=effect2,label=pieceCount1; Jump,condition=CheckTrue,goto=pieceCount2; PlayCasterBindEffect,effectID=PARAM.effectID3,label=effect2; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=PARAM.effectID6,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType=InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID7,turnToTarget=1,deathClear=0; Jump,condition=CheckTrue,goto=phaseEnd; PlayCasterBindEffect,effectID=PARAM.effectID3,label=pieceCount2; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=PARAM.effectID8,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType=InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID9,turnToTarget=1,deathClear=0 "
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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
