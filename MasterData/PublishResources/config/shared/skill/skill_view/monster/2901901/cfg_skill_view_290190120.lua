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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6166,audioType=1; PlayCasterBindEffect,effectID=3387; Wait,waitTime=550; PlayTeleportAsMoving,time=100; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3388,turnToTarget=1,deathClear=0; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
