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
      " PlayCasterAnimation,animName=AtkChain; PlayCasterBindEffect,effectID=3534; PlayCasterBindEffect,effectID=3535; "
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
      " PlayAudio,audioID = 2449,audioType=1; Wait,waitTime=50; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    72,
    1,
    1,
    0,
    {
      scopeHorizontalOrVertical = 1,
      trajectoryEffectID = 3537,
      trajectoryEffectOffset = 0,
      sidesEffectID = 3536,
      sidesEffectDelayMS = 1000,
      trajectoryTime = 50,
      totalTime = 400,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      hitEffectTime = 0,
      clearBodyNow = 0,
      damageIndex = 1,
      beginDelayTime = 100,
      trajectoryFollowingEffectID = 0,
      trajectoryFinishEffectID = 3538,
      trajectoryFinishEffectTime = 1000,
      tailDismissDelay = 3000,
      trajectoryFlightEndOffset = 2
    }
  }
}
return config, "ID", key
