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
      " PlayCasterAnimation,animName = Skill03; PlayAudio,audioID = 5101,audioType=1; PlayCasterBindEffect,effectID=672; "
    }
  },
  {
    2,
    2,
    75,
    1,
    1,
    1000,
    {
      pathEffectID = 673,
      hitEffectID = 674,
      interval = 150
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    4,
    4,
    23,
    2,
    2,
    500,
    {showTime = 0}
  }
}
return config, "ID", key
