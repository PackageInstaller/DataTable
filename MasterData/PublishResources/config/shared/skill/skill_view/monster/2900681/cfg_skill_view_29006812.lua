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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName =Skill02; PlayCasterBindEffect,effectID=3120; Wait,waitTime=300; PlayCasterBindEffect,effectID=3122; Wait,waitTime=1000; PlayAudio,audioID = 6125,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=3123,isRotate=1,randomRotate=0.3; Wait,waitTime=300; PlayCasterBindEffect,effectID=3123,isRotate=1,randomRotate=0.3; Wait,waitTime=150; PlayCasterBindEffect,effectID=3123,isRotate=1,randomRotate=0.3; Wait,waitTime=150; "
    }
  },
  {
    2,
    2,
    34,
    2,
    1,
    0,
    {
      gridEffectID = 3121,
      gridEffectDelayTime = 0,
      gridIntervalTime = 100,
      showTimeDelay = 1000
    }
  }
}
return config, "ID", key
