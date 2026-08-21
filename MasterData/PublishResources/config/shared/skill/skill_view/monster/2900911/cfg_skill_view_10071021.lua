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
      " PlayDeleteWaringArea; PlayCasterAnimation,animName=Skill01; PlayEffectAGridPos,effectID=3038,gridPosX=5,gridPosY=6; PlayAudio,audioID = 6110,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID =3037; Wait,waitTime=500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
