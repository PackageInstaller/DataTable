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
    105,
    1,
    0,
    0,
    {
      startAction = "Skill04_Start",
      startEffectID = 290530112,
      hideDelay = 500,
      attackEffectID = 290530114,
      attackCameraEffectID = 290530117,
      dashAudioID = 6294,
      secondDashDelay = 100,
      dashInterval = 100,
      showEffectDelay = 450,
      showDelay = 100,
      showEffectID = 290530113,
      endAction = "Skill04_End",
      beHitAnimation = "Hit",
      beHitEffectID = 290530115,
      finalBeHitEffectID = 290530116,
      finalDelay = 1000
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    900,
    {
      " PlayRecoverFromGreyHP; "
    }
  }
}
return config, "ID", key
