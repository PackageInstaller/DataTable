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
      " PlayTurnToSpecifiedDir,dirX=0,dirY=-1; Wait,waitTime=100; PlayCasterAnimation,animName=Skill02_R; PlayCasterBindEffect,effectID =3033; PlayCasterBindEffect,effectID =3035; PlayAudio,audioID = 6115,audioType=1; Wait,waitTime=2000; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3036,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
