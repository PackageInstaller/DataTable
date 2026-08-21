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
      " PlayCasterAnimation,animName = CallIn; PlayCasterAttachmentAnimation,animName = CallIn; PlayAudio,audioID=6154,audioType=1; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = CallOut; PlayCasterAttachmentAnimation,animName = CallOut; PlayAudio,audioID=6161,audioType=1; Wait,waitTime=800; PlayCasterBindEffect,effectID=3308; Wait,waitTime=1000; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      "PlayIncreaseSan;"
    }
  }
}
return config, "ID", key
