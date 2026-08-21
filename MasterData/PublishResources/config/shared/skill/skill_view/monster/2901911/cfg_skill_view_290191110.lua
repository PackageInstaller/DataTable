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
      " PlayTurnToTeleportNewPos; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=6174,audioType=1; PlayTeleportAsMoving,time=100; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCasterTurnToTargetNormal; Wait,waitTime=200; PlayCasterBindEffect,effectID=3435; Wait,waitTime=100; "
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
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3436,turnToTarget=1; Wait,waitTime=300; "
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
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3436,turnToTarget=1; "
    }
  }
}
return config, "ID", key
