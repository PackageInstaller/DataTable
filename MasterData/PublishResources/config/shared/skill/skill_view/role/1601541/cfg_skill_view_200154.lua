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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3593; PlayCasterBindEffect,effectID =3595; PlayAudio,audioID = 2464,audioType=1; "
    }
  },
  {
    2,
    2,
    92,
    2,
    1,
    1200,
    {
      effectID = 3594,
      spawnIntervalTime = 30,
      spawnCenterBone = "Hit",
      spawnRadiusMin = 0,
      spawnRadiusMax = 1.3,
      waitFireTime = 0,
      flyTime = 100,
      destroyBulletDelay = 0,
      targetHit = "Hit",
      turnToTarget = 1,
      hitAnimName = "Hit",
      hitEffectID = 3592,
      oneArrowOffsetX = -0.106,
      oneArrowOffsetY = 1.844,
      oneArrowOffsetZ = 0.662
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    300,
    {
      " Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
