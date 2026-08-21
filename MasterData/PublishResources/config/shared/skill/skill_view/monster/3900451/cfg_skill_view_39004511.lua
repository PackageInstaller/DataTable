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
      " PlayCasterAnimation,animName = skill01; PlayAudio,audioID = 6033,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectskill01; PlayCasterBindEffect,effectID=PARAM.effectfire; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = PARAM.effectatk,flySpeed = 100,flyTrace = 1,offsety=0,offsetz=0; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=false; "
    }
  }
}
return config, "ID", key
