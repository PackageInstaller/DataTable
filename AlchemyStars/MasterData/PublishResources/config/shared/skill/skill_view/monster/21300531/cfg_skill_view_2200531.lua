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
    2,
    1,
    0,
    0,
    {
      effectparam = "990",
      castAnimationName = "AtkChain",
      finishDelayTime = 3200,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayAudio,audioID = 2108,audioType=1; Wait,waitTime=50; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1200,
    {
      "DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=redoDamage; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=redoDamage;"
    }
  }
}
return config, "ID", key
