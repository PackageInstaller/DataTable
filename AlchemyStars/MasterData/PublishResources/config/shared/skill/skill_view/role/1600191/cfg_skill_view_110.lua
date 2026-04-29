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
    2,
    1,
    0,
    0,
    {
      effectparam = "347,348",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 1200,
      buffNeedImmediatelyEffect = 0
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
      "PlayAudio,audioID = 2177,audioType=1; Wait,waitTime=600; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    7,
    1,
    1,
    1300,
    {
      gridEffectID = 349,
      columnInternalTime = 0,
      hitAnimName = "Hit",
      hitEffectID = 0,
      gridEffectWaitTime = 1000,
      hitWaitTime = 0
    }
  }
}
return config, "ID", key
