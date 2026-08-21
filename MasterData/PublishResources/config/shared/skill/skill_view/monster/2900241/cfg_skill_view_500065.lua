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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    50,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20011; "
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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
