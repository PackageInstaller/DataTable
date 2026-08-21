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
      " Jump,condition=CheckHasTeleport,param=1,goto=phaseEnd; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayCasterAnimation,animName=skill02; PlayCasterBindEffect,effectID=200240104; PlayTeleportAsMoving,time=200,notifyBuff=1; Wait,waitTime=200; PlayDeleteCasterEffect,effectIDList=200240104; "
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=200; DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayAudio,audioID = 6257,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200240103,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
