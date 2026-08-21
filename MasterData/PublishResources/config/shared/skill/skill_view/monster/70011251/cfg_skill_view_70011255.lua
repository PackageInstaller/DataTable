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
    1500,
    {
      "Wait,waitTime=1000; PlaySummonTrap,trapID=141;"
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
      " PlayCasterBindEffect,effectID=290350111; PlayCasterAnimation,animName = skill03_1; Wait,waitTime=1000; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    43,
    1,
    0,
    1000,
    {audioID = 6237, audioType = 1}
  }
}
return config, "ID", key
