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
    45,
    1,
    0,
    0,
    {
      prob = 100,
      tipsList = {290021101}
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
      "PlayCasterTurnToTarget;"
    }
  },
  {
    3,
    3,
    74,
    1,
    1,
    0,
    {
      hitAnimName = "Hit",
      hitDelayTime = 0,
      hitEffectID = "PARAM.effectID1",
      casterAnimName = "Skill04",
      castEffectID = "PARAM.effectID2",
      noTrapCasterEffectID = "PARAM.effectID3",
      successCasterEffectID = "PARAM.effectID4",
      trapStartDelay = 1200,
      trapTrajectoryID = "PARAM.effectID5",
      trapStartHeight = 0,
      trapEndHeight = 2,
      trapFlyTotalTime = 500,
      bowlderStartDelay = 2700,
      bowlderTrajectoryID = 1183,
      bowlderStartHeight = 4,
      bowlderEndHeight = 0,
      bowlderFlyTotalTime = 100
    }
  },
  {
    4,
    4,
    43,
    1,
    1,
    0,
    {audioID = 6004, audioType = 1}
  }
}
return config, "ID", key
