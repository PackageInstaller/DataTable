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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName=Skill01; PlayAudio,audioID = 7030,audioType=1; PlayTurnToTeleportNewPos; PlayCasterBindEffect,effectID=2536; PlayCasterBindEffect,effectID=2537; PlayCasterBindEffect,effectID=2538; Wait,waitTime=1167; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTurnToChessKnight; Wait,waitTime=2000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=500; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    100,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayTurnToChessKnight; Wait,waitTime=2000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
