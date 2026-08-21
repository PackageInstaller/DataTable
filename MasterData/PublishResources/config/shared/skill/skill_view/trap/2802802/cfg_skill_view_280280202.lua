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
      " PlayCasterAnimation,animName=Death; Wait,waitTime=2000; "
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
      " PlaySummonMonsterBySummonEveryThing,fromCage=1, cageSummonDelayTime=1100, cageSummonMoveTime=1000, cageSummonUnderDis=-2.4, cageSummonMatAnim=effanim_2802802_call_m; "
    }
  }
}
return config, "ID", key
