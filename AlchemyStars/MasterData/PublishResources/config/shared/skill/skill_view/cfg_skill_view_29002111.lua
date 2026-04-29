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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29002111,remove=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      "PlayCasterTurnToTarget;"
    }
  },
  {
    4,
    4,
    74,
    1,
    3,
    0,
    {
      hitAnimName = "Hit",
      hitDelayTime = 0,
      hitEffectID = 677,
      casterAnimName = "Skill04",
      castEffectID = 678,
      noTrapCasterEffectID = 675,
      successCasterEffectID = 676,
      trapStartDelay = 1200,
      trapTrajectoryID = 680,
      trapStartHeight = 0,
      trapEndHeight = 2,
      trapFlyTotalTime = 500,
      bowlderStartDelay = 2700,
      bowlderTrajectoryID = 679,
      bowlderStartHeight = 4,
      bowlderEndHeight = 0,
      bowlderFlyTotalTime = 100
    }
  },
  {
    5,
    5,
    43,
    1,
    3,
    0,
    {audioID = 5099, audioType = 1}
  },
  {
    6,
    6,
    0,
    2,
    4,
    0,
    {
      "Wait,waitTime=3000;"
    }
  }
}
return config, "ID", key
