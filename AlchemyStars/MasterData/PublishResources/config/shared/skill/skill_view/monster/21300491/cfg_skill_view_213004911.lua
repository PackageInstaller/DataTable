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
      effectparam = "999",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 0
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayAudio,audioID = 2099,audioType=1; Wait,waitTime=1700; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    31,
    1,
    1,
    2360,
    {
      gridEffectID = 998,
      gridIntervalTime = 33,
      finishDelayTime = 500,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
