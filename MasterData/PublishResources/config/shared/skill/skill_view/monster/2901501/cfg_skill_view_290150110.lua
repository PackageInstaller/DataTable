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
      " PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=3302; PlayAudio,audioID=6163,audioType=1; Wait,waitTime=1000; "
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
      " PlayCasterAttachmentAnimation,animName = Skill01; PlayCasterBindEffect,effectID=3318; PlayAudio,audioID=6151,audioType=1; Wait,waitTime=800; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayCasterBindEffect,effectID=3319; Wait,waitTime=1280; "
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
      " PlayCasterAnimation,animName = Skill022; PlayAudio,audioID=6148,audioType=1; PlayCasterBindEffect,effectID=3303; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
