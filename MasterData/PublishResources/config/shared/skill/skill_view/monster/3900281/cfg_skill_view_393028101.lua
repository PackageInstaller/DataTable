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
      " PlayCasterAnimation,animName =skill01_1; PlayAudio,audioID = 5006,audioType=1; PlayCasterBindEffect,effectID=913; PlayCasterBindEffect,effectID=914; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    1800,
    {
      gridEffectID = 909,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 1000
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    2900,
    {
      " PlayCasterLineRenderer,group=Monster|Trap,targerEffectType=3026,lineEffectID=924,lineTarget=Hit,lineCurrent=Hit; "
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
      " PlayCasterAnimation,animName =Skill01; PlayAudio,audioID = 5007,audioType=1; PlayCasterBindEffect,effectID=911; "
    }
  },
  {
    5,
    5,
    31,
    2,
    4,
    1200,
    {
      gridEffectID = 912,
      gridIntervalTime = 100,
      finishDelayTime = 500,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
