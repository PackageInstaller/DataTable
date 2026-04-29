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
      anim1 = "Skill01_a",
      anim2 = "Skill01_b",
      materialAnim1 = "eff_2903401_skill01_mat",
      materialAnim2 = "eff_2903401_skill01_mat02",
      flyEffectID = 290340114,
      mainEffectID1 = 290340113,
      mainEffectID2 = 290340119,
      oneGridFlyTime = 200,
      delayFlyTime = 400,
      finishTime = 1000
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID =6229,audioType=1; "
    }
  }
}
return config, "ID", key
