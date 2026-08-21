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
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitEffectID=0,turnToTarget=1,deathClear=0; "
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
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    50,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20011; "
    }
  }
}
return config, "ID", key
