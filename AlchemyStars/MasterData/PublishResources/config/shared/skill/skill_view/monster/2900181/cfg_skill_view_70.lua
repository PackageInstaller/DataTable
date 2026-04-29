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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=861; PlayCasterBindEffect,effectID=862; PlayCasterTurnToTarget; PlayAudio,audioID=5050; Wait,waitTime=750; PlayFlyEffectCasterToTarget,flyEffectID = 863,flySpeed = 100,flyTrace = 1,offsety=0.8; DataSelectDamageInfo,damageInfoIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=864,turnToTarget=1,deathClear=true; Wait,waitTime=100; DataSelectDamageInfo,damageInfoIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=864,turnToTarget=1,deathClear=true; "
    }
  }
}
return config, "ID", key
