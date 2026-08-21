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
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6284,audioType=1; PlayCasterBindEffect,effectID=290520106; Wait,waitTime=1600; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=290520107,flyTime=200,flyTrace=1,offsety=1.7,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290520108,turnToTarget=1,deathClear=0; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
