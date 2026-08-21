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
      " Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayTurnToTeleportNewPos; PlayCasterBindEffect,effectID=2544; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 7031,audioType=1; Wait,waitTime=100; PlayCasterBindEffect,effectID=2545; PlayCasterAnimation,animName = Skill01_2; PlayAudio,audioID = 6044,audioType=1; PlayTeleportAsMoving,speed=12; "
    }
  },
  {
    2,
    2,
    38,
    2,
    1,
    0,
    {
      effectIDList = {2545}
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    50,
    {
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCasterTurnToTarget; PlayCasterAnimation,animName = Skill01_3; PlayCasterBindEffect,effectID=2546; Wait,waitTime=1600; PlayFlyEffectCasterToTarget,flyEffectID=2547,flySpeed=150,flyTrace=1,offsety=0.76,offsetz=0.88,flyEaseType=InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2548,turnToTarget=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=2000704; Wait,waitTime=1000; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayCasterAnimation,animName =Idle; "
    }
  }
}
return config, "ID", key
