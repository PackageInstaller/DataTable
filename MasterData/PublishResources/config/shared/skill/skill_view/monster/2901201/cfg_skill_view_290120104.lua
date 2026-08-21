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
      " PlayGridDark,darkType=0; PlayCasterAnimation,animName = Skill03; PlayAudio,audioID=6131,audioType=1; PlayCasterBindEffect,effectID=3167; PlayCasterBindEffect,effectID=3169; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=2000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3168,turnToTarget=1,deathClear=0; PlayGridDark,darkType=1; "
    }
  },
  {
    3,
    3,
    36,
    1,
    1,
    2000,
    {
      gridEffectID = 3343,
      gridEffectDelayTime = 1000,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
