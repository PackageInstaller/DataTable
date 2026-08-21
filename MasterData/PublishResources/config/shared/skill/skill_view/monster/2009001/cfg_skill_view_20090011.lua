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
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 200900101,audioType=1; PlayCasterBindEffect,effectID=200900101; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 200900102,flyTime = 500,offsetx=0,offsety=0.73,offsetz=0.15,flyTrace = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200900103,turnToTarget=1,deathClear=0; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
