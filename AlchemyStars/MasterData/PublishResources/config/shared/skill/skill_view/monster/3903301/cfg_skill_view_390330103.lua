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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect, effectID=2641; PlayCameraEffect, effectID=2642; Wait,waitTime=3000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2643,turnToTarget=1,deathClear=false; Wait,waitTime=2200; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 2319, audioType = 1}
  }
}
return config, "ID", key
