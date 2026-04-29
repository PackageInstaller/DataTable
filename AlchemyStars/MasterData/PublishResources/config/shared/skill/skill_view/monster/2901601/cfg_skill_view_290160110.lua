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
      " PlayCasterAttachmentAnimation,animName = Skill02; Wait,waitTime=500; PlayCasterBindEffect,effectID=3307; Wait,waitTime=500; PlayCasterBindEffect,effectID=3306; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=500; PlaySummonTrap,trapID=60; Wait,waitTime=1200; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    1000,
    {
      "PlayMultiTraction;"
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayCasterAnimation,animName = Skill022; PlayCasterBindEffect,effectID=3303; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
