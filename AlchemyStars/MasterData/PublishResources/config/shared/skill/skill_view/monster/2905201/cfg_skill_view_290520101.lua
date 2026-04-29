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
      " PlayCasterAnimation,animName=Skill01; PlayAudio,audioID=6283,audioType=1; PlayCasterBindEffect,effectID =290520102; PlayCasterBindEffect,effectID =290520104; Wait,waitTime=1400; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290520103,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayTeleportAsMoving,time=500; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
