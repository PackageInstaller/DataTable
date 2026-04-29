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
      effectparam = "411",
      castAnimationName = "AtkChain",
      finishDelayTime = 200,
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
      " PlayAudio,audioID = 2120,audioType=1; Wait,waitTime=50; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    15,
    1,
    1,
    1000,
    {
      bornEffectDelay = 0,
      bornEffectID = 0,
      flyStartMs = 0,
      gridEffectID = 413,
      flyOneGridMS = 150,
      hitAnimName = "Hit",
      hitEffectID = 0,
      disappearEffectID = 412,
      finishWaitTime = 1500
    }
  }
}
return config, "ID", key
