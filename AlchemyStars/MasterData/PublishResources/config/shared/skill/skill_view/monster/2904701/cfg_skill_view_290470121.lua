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
      " PlayCasterAnimation,animName=Atk; PlayCasterBindEffect,effectID=290470101; Wait,waitTime=585; PlayAudio,audioID=6265,audioType=1; Wait,waitTime=100; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290470102,turnToTarget=1,deathClear=0; Wait,waitTime=2050; "
    }
  }
}
return config, "ID", key
