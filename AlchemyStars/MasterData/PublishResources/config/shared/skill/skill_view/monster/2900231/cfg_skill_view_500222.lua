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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=828; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 5089, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    900,
    {
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 829,flySpeed = 50,flyTrace = 1,offsety=0.65,offsetz=0.75; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=830,turnToTarget=1,deathClear=false; "
    }
  }
}
return config, "ID", key
