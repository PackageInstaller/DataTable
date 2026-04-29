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
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 7021,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=PARAM.effectID1; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=PARAM.effectID2,flyTime=400,flyTrace=1,offsety=0.4,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID3,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
