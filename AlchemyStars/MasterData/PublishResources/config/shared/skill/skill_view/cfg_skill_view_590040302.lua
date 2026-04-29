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
    94,
    1,
    0,
    0,
    {
      useSuper = true,
      anim1 = "Birth02",
      anim2 = "Birth02",
      materialAnim1 = "eff_2903401_skill01_mat",
      materialAnim2 = "eff_2903401_skill01_mat02",
      flyEffectID = 10,
      mainEffectID1 = 1380,
      mainEffectID2 = 1380,
      oneGridFlyTime = 10,
      delayFlyTime = 10,
      finishTime = 1000
    }
  }
}
return config, "ID", key
