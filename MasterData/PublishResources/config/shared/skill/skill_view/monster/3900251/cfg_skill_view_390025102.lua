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
      " PlayCasterAnimation,animName=Skill01_aoe; PlayAudio,audioID = 5028,audioType=1; Wait,waitTime=150; PlayCasterBindEffect,effectID=651; "
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
      bulletBornEftID = 652,
      bornDuration = 1200,
      bulletEftID = 653,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 654,
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
      bulletBornEftID = 652,
      bornDuration = 1200,
      bulletEftID = 653,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 654,
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
      bulletBornEftID = 652,
      bornDuration = 1200,
      bulletEftID = 653,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 654,
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
      bulletBornEftID = 652,
      bornDuration = 1200,
      bulletEftID = 653,
      flyDuration = 200,
      distanceToEdge = 1.5,
      beHitAnim = "Hit",
      beHitEft = 654,
      turnToTarget = true,
      deathClear = false
    }
  }
}
return config, "ID", key
