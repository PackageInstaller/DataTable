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
      " PlayTurnToTeleportNewPos; PlayCasterAnimation,animName =Skill01; PlayAudio,audioID = 7027,audioType=1; PlayCasterBindEffect,effectID=2617; PlayEffectTeleportNewPos , effectID=2616; Wait,waitTime=500; PlayTeleportAsMoving,speed=12; PlayTurnToSpecifiedDir,dirX=0,dirY=-1; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
