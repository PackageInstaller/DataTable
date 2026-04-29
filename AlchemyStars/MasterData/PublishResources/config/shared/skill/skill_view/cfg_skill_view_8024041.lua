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
      " Wait,waitTime=1000; PlayCasterBindEffect,effectID=1020; PlayCasterBindEffect,effectID=5352031; Wait,waitTime=200; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    2000,
    {
      " Wait,waitTime=2000; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
