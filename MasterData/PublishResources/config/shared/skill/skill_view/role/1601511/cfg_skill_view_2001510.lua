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
      " PlayCasterBindEffect,effectID=3552; PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2453,audioType=1; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    90,
    2,
    1,
    500,
    {
      effectID = 3554,
      spawnRadiusMin = 0.3,
      spawnRadiusMax = 0.45,
      upSpeed = 0.5,
      upShakeDisX = 0.5,
      upShakeDisY = 0,
      upShakeDisZ = 0.5,
      upShakeDertaTimeMin = 200,
      upShakeDertaTimeMax = 600,
      fireTimeMin = 800,
      fireTimeMax = 1300,
      flyTime = 1300,
      flyRandomDis = 2,
      flyRandomPointCount = 15,
      destroyBulletDelay = 1000,
      targetHitOffsetMin = 0,
      targetHitOffsetMax = 0.25,
      targetHit = "Hit",
      turnToTarget = 1,
      hitAnimName = "Hit",
      hitEffectID = 3553,
      hitPointDelay = 200
    }
  }
}
return config, "ID", key
