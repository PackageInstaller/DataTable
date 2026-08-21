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
      " PlayCasterAnimation,animName =Skill01; Wait,waitTime=500; PlayCasterBindEffect,effectID=2417; PlayAudio,audioID = 6078,audioType=1; "
    }
  },
  {
    2,
    2,
    36,
    1,
    1,
    3000,
    {
      gridEffectID = 3343,
      gridEffectDelayTime = 1000,
      gridIntervalTime = 0,
      showTimeDelay = 0
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=584,turnToTarget=0,deathClear=0; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
