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
      "PlayZhongxuWaitRevert;"
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =160181110; PlayAudio,audioID = 2584,audioType=1; Wait,waitTime=396; "
    }
  },
  {
    3,
    3,
    90,
    1,
    2,
    1700,
    {
      effectID = 160181111,
      offsetPosX = 0.25,
      offsetPosY = 1.628,
      offsetPosZ = -0.33,
      fireTimeMin = 1701,
      fireTimeMax = 2205,
      flyTime = 980,
      flyRandomDis = 2,
      flyRandomPointCount = 10,
      destroyBulletDelay = 2000,
      targetHitOffsetMin = 0,
      targetHitOffsetMax = 0,
      targetHit = "Hit",
      turnToTarget = 1,
      hitAnimName = "Hit",
      hitEffectID = 160181112,
      hitSoundID = 0,
      hitPointDelay = 0
    }
  }
}
return config, "ID", key
