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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=851; PlayCasterBindEffect,effectID=852; PlayCasterTurnToTarget; PlayAudio,audioID=5051; Wait,waitTime=500; PlayFlyEffectCasterToTarget,flyEffectID = 853,flySpeed = 100,flyTrace = 1,offsety=0.8; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=854,turnToTarget=1,deathClear=true; "
    }
  }
}
return config, "ID", key
