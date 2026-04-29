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
      " PlayCasterAnimation,animName=skill01_1; PlayCasterBindEffect,effectID=290350101; Wait,waitTime=900; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=203,turnToTarget=1,deathClear=0,label=doAgain; PlaySummonTrap,trapID=2030; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    500,
    {audioID = 6234, audioType = 1}
  }
}
return config, "ID", key
