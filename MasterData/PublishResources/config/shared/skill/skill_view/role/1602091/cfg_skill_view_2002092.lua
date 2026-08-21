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
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 2683,audioType=1; PlayCasterBindEffect,effectID=160209107; PlayCasterBindEffect,effectID=160209108; "
    }
  },
  {
    2,
    2,
    109,
    1,
    1,
    0,
    {
      animatorTriggerName = "AtkChain",
      highJumpEffectDelay = 500,
      highJumpEffectID = 160209112,
      diveDelay = 1100,
      diveTrajectoryEffectID = 160209109,
      diveEffectFlyTime = 150,
      groundHitEffectID = 160209111,
      hitDelay = 50,
      disappearDelay = 1200,
      disappearEffectID = 160209113,
      appearEffectDelay = 500,
      appearEffectID = 160209114,
      appearDelay = 20
    }
  }
}
return config, "ID", key
