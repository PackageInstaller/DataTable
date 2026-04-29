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
      effectparam = "366",
      castAnimationName = "AtkChain",
      finishDelayTime = 0,
      buffDelayTime = 0,
      buffNeedImmediatelyEffect = 0
    },
    {"", "1,0"}
  },
  {
    2,
    2,
    0,
    1,
    1,
    200,
    {
      "PlayAudio,audioID = 3032,audioType=1; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    31,
    1,
    1,
    700,
    {
      gridEffectID = 367,
      gridIntervalTime = 100,
      finishDelayTime = 1000,
      hasDamage = 1,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      gridEffectDirection = "Up"
    }
  }
}
return config, "ID", key
