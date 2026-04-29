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
      " PlayCasterAnimation,animName = skill03; PlayCasterBindEffect,effectID =290370103; PlayCasterBindEffect,effectID =290370105; Wait,waitTime=250; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290370107,turnToTarget=1,deathClear=0; PlayAudio,audioID = 6215,audioType=1; Wait,waitTime=1250; "
    }
  }
}
return config, "ID", key
