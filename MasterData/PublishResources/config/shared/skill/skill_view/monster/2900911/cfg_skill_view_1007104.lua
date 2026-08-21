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
      " PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=3041; PlayCasterBindEffect,effectID=3043; PlayAudio,audioID =6112,audioType=1; Wait,waitTime=2400; PlayCasterBindEffect,effectID=3042; Wait,waitTime=600; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1900; "
    }
  }
}
return config, "ID", key
