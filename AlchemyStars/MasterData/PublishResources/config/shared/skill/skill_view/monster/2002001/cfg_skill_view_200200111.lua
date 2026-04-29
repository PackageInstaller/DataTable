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
      " PlayCasterBindEffect,effectID=200200102; Wait,waitTime=300; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200200103,turnToTarget=1,deathClear=0,label=doDamageAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doDamageAgain; Wait,waitTime=1900; "
    }
  }
}
return config, "ID", key
