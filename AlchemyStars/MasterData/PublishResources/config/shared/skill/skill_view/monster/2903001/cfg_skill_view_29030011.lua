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
      " Wait,waitTime=1000; PlayCasterAnimation,animName =Skill01; PlayRubikMultiLaserEffect,effectID=3815; PlayAudio,audioID = 6204,audioType=1; Wait,waitTime=2000; DataSelectDamage,damageIndex =1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3816,turnToTarget=1,deathClear=0; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
