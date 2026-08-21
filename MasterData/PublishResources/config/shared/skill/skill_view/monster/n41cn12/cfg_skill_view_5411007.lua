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
      " Wait,waitTime=1000; PlayCasterBindEffect,effectID=1020; Wait,waitTime=200; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    60,
    1,
    0,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 5352031
      }
    }
  },
  {
    3,
    3,
    30,
    2,
    1,
    0,
    {
      gridEffectID = 0,
      bestEffectTime = 0,
      finishDelayTime = 1000
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlaySummonTrap,trapID=2803501; Wait,waitTime=100; DataSelectResult,effectType=79,index=1; PlayDestroyTrap;"
    }
  }
}
return config, "ID", key
