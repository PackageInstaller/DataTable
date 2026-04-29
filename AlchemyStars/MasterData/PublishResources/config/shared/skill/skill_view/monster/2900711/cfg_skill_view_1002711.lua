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
      " Wait,waitTime=200; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID = 2034,audioType=1; PlayCasterTurnToTarget; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = PARAM.effectID2,flyTime = 600,flyTrace = 3; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID3,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
