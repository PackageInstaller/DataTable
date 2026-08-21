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
      " Wait,waitTime=500; PlayAudio,audioID = 6205,audioType=1; Wait,waitTime=500; DataSelectDamage,damageIndex =1; PlayCasterAnimation,animName =Skill02; PlayCasterBindEffect,effectID=3817; PlayEffectAGridPos,effectID=3818,gridPosX=4,gridPosY=4; Wait,waitTime=800; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
