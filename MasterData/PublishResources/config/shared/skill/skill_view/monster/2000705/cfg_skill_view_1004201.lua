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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 7033,audioType=1; PlayCasterTurnToTarget; Wait,waitTime=200; "
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
      " PlayCasterAnimation,animName = Skill01_2; PlayCasterBindEffect,effectID=2554; PlayAudio,audioID = 6044,audioType=1; PlayTeleportAsMoving,speed=12; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    50,
    {
      " PlayCasterAnimation,animName = Skill01_3; PlayCasterBindEffect,effectID=2555; Wait,waitTime=850; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=300; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; "
    }
  }
}
return config, "ID", key
