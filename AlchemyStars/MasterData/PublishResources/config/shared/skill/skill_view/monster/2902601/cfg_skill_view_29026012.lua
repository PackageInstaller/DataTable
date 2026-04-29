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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID = 5028,audioType=1; PlayCasterBindEffect,effectID=3559; Wait,waitTime=400; "
    }
  },
  {
    2,
    2,
    76,
    2,
    1,
    0,
    {
      direction = 1,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    3,
    3,
    76,
    2,
    1,
    0,
    {
      direction = 2,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    4,
    4,
    76,
    2,
    1,
    0,
    {
      direction = 3,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    5,
    5,
    76,
    2,
    1,
    0,
    {
      direction = 4,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    6,
    6,
    76,
    2,
    1,
    0,
    {
      direction = 5,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    7,
    7,
    76,
    2,
    1,
    0,
    {
      direction = 6,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    8,
    8,
    76,
    2,
    1,
    0,
    {
      direction = 7,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  },
  {
    9,
    9,
    76,
    2,
    1,
    0,
    {
      direction = 8,
      bulletBornEftID = 3560,
      bornDuration = 1200,
      bulletEftID = 3561,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 3562,
      turnToTarget = true,
      deathClear = false
    }
  }
}
return config, "ID", key
