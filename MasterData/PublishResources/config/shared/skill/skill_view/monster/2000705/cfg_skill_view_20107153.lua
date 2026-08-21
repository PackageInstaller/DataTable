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
    2,
    0,
    0,
    {
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 7032,audioType=1; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2041, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayCasterAddBuff, buffID =20107151; PlayCasterVisible, visible=1; "
    }
  },
  {
    4,
    4,
    36,
    1,
    1,
    500,
    {
      gridEffectID = 2908,
      gridEffectDelayTime = 1000,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  },
  {
    5,
    5,
    0,
    1,
    4,
    0,
    {
      " Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
