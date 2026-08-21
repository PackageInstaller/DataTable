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
      " PlayCoffinMusumeTurnAndSwitchBody,isUp=1; PlayAudio,audioID=6221,audioType=1; Wait,waitTime=500; PlayCasterBindEffect,effectID=290380103; Wait,waitTime=500; PlayCoffinMusumeTurnAndSwitchBody,isUp=0; Wait,waitTime=800; PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6222,audioType=1; PlayCasterBindEffect,effectID=290380104; PlayTeleportAsMoving,time=500; Wait,waitTime=500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3388,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
