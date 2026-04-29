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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID = 5006,audioType=1; PlayCasterBindEffect,effectID=877; PlayCasterBindEffect,effectID=878; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    700,
    {
      gridEffectID = 873,
      gridEffectDelayTime = 0,
      gridIntervalTime = 100,
      showTimeDelay = 1000
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1900,
    {
      " PlayCasterLineRenderer,group=Monster|Trap,targerEffectType=3026,lineEffectID=888,lineTarget=Hit,lineCurrent=Hit; "
    }
  },
  {
    4,
    4,
    36,
    1,
    1,
    4000,
    {
      gridEffectID = 881,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
