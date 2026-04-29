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
      " DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=1016,flySpeed=100,flyTrace=2,offsetx=1,offsety=0,offsetz=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1017,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
