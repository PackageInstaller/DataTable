local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,turnToTarget=0,deathClear=0,label=Damage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,result=1,goto=Damage;"
    }
  }
}
return config, "ID", key
