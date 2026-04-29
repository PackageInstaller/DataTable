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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=290580102; PlayAudio,audioID =290580101,audioType=1; Wait,waitTime=1100; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
