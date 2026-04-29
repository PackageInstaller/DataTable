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
    88,
    1,
    0,
    0,
    {
      casterAnimName = "Skill01",
      castEffectID = 3411,
      monsterEndHeight = 0,
      monsterFlyTotalTime = 500,
      monsterFlyToPos = {5, 8},
      monsterMinScale = 0.3,
      bowlderStartDelay = 0,
      bowlderStartPos = {
        0,
        0.45,
        3
      },
      bowlderJumpHeight = 1,
      bowlderTrajectoryID = 3412,
      bowlderEndHeight = 0.5,
      bowlderFlyTotalTime = 500,
      stealthDuration = 550,
      hitAnim = "Hit",
      hitEffectID = 3410
    }
  }
}
return config, "ID", key
