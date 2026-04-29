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
      " PlayDeleteWaringArea; "
    }
  },
  {
    2,
    2,
    60,
    1,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 5},
        effectID = 280230101
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    600,
    {
      " PlayDeleteWaringArea; PlayEffectOffsetScopeCenter,effectID=280230105,offset=0|0; PlayAudio,audioID = 8023,audioType=1; Wait,waitTime=200; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1150; "
    }
  }
}
return config, "ID", key
