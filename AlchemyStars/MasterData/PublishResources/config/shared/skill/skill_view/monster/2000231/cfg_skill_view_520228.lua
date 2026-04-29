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
      " PlayCasterAnimation,animName=Absorb; PlayAudio,audioID = 7013,audioType=1; PlayAbsorbPieceEffect,flyEffectID=817,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=150,targetPos=Hit,waitFlyEffectTime=800; PlayCasterBindEffect,effectID=821; Wait,waitTime=1000; PlaySummonTrap,trapID=60; "
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
      " DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayCasterAnimation,animName=Atk; PlayAudio,audioID = 7012,audioType=1; Wait,waitTime=400; Jump,condition=CheckAbsortPieceCountLessThan,param=3,goto=effect1; Jump,condition=CheckTrue,goto=pieceCount1; PlayCasterBindEffect,effectID=787,label=effect1; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=793,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType= InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=805,turnToTarget=1,deathClear=0; Jump,condition=CheckTrue,goto=phaseEnd; Jump,condition=CheckAbsortPieceCountLessThan,param=6,goto=effect2,label=pieceCount1; Jump,condition=CheckTrue,goto=pieceCount2; PlayCasterBindEffect,effectID=787,label=effect2; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=792,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType= InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=804,turnToTarget=1,deathClear=0; Jump,condition=CheckTrue,goto=phaseEnd; PlayCasterBindEffect,effectID=787,label=pieceCount2; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=791,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType= InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=803,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
