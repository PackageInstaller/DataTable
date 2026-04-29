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
      " PlayRoleTeleport, type=5, onlySelf=0; PlayRoleTeleport, type=6; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2050, audioType = 1}
  },
  {
    3,
    3,
    2,
    1,
    1,
    0,
    {
      castAnimationName = "Land",
      finishDelayTime = 2902,
      buffDelayTime = 0
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    200,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    200,
    {
      " PlayEffectAtCasterPos, effectID=1236; "
    }
  }
}
return config, "ID", key
