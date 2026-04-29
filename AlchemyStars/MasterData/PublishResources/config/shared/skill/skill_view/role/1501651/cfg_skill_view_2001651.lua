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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =3797; PlayAudio,audioID = 2503,audioType=1; Wait,waitTime=396; PlayCasterVisible,visible=0; Wait,waitTime=4026; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkChain1; "
    }
  },
  {
    2,
    2,
    90,
    1,
    1,
    2450,
    {
      effectID = 3798,
      offsetPosX = 0,
      offsetPosY = 1.5,
      offsetPosZ = -0.33,
      fireTimeMin = 10,
      fireTimeMax = 1200,
      flyTime = 1000,
      flyRandomDis = 8,
      flyRandomPointCount = 3,
      destroyBulletDelay = 1000,
      targetHitOffsetMin = 0,
      targetHitOffsetMax = 0.1,
      targetHit = "Hit",
      turnToTarget = 1,
      hitAnimName = "Hit",
      hitEffectID = 3800,
      hitSoundID = 2504,
      hitPointDelay = 0,
      fireEffectID = 3799,
      disableRoot = "1501651_daodan",
      summonTrapWithHit = 1,
      summonTrapEffectID = 0,
      summonTrapDirToTarget = 1,
      needLookAt = 1,
      firstPosX = 0,
      firstPosY = 1,
      firstPosZ = 0,
      firstPosRandom = 0.5
    }
  }
}
return config, "ID", key
