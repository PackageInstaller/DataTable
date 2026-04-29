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
    2,
    0,
    0,
    {
      " PlayCasterAnimation,animName=AtkChain; PlayCasterBindEffect,effectID=3258; PlayCasterBindEffect,effectID=3260; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayAudio,audioID = 2399,audioType=1; Wait,waitTime=50; PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    3,
    3,
    72,
    2,
    1,
    1250,
    {
      scopeHorizontalOrVertical = 2,
      trajectoryEffectID = 3259,
      trajectoryEffectOffset = 0,
      trajectoryTime = 50,
      totalTime = 300,
      hitAnimationName = "Hit",
      hitEffectID = 0,
      hitEffectTime = 0,
      clearBodyNow = 0,
      damageIndex = 1,
      beginDelayTime = 100,
      trajectoryFollowingEffectID = 3259,
      trajectoryFinishEffectID = 3259,
      trajectoryFinishEffectTime = 1000,
      tailDismissDelay = 3000
    }
  },
  {
    4,
    4,
    0,
    1,
    3,
    0,
    {
      " Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
