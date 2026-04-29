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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID = 5006,audioType=1; PlayCasterBindEffect,effectID=895; PlayCasterBindEffect,effectID=896; "
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
      gridEffectID = 891,
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
      " PlayCasterLineRenderer,group=Monster|Trap,targerEffectType=3026,lineEffectID=906,lineTarget=Hit,lineCurrent=Hit; "
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
      gridEffectID = 889,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    500,
    {
      " PlayCasterRenderState,renderState=1; PlayCasterAnimation,animName=Skill03_a; PlayCasterBindEffect,effectID=900; PlayAudio,audioID = 5005,audioType=1; Wait,waitTime=2167; PlayCasterBindEffect,effectID=901; PlayCasterBindEffect,effectID=973; PlayCasterAddBuff,buffID=30072; Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
