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
      " PlayCasterAnimation,animName = atk01; PlayCasterBindEffect,effectID=200250101; Wait,waitTime=450; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=200250102,flyTime=150,flyTrace=1,offsety=1,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200250103,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    120,
    {audioID = 6259, audioType = 1}
  }
}
return config, "ID", key
