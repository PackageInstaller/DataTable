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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6172,audioType=1; PlayCasterBindEffect,effectID=3375; DataSelectDamage,damageIndex=1; Wait,waitTime=1200; PlayFlyEffectCasterToTarget,flyEffectID=3376,flyTime=500,flyTrace=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3374,turnToTarget=1,deathClear=0; PlayShuffleTeamOrder; "
    }
  }
}
return config, "ID", key
