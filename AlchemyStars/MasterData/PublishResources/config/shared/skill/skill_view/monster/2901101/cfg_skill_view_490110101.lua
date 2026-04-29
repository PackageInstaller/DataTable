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
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 7005,audioType=1; PlayCasterBindEffect,effectID=1067; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1068,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    36,
    1,
    1,
    1000,
    {
      gridEffectID = 3343,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
