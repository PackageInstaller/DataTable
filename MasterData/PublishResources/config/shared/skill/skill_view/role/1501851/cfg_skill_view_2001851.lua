local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 2597,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =150185107; PlayCasterBindEffect,effectID =150185111; "
    }
  },
  {
    2,
    2,
    97,
    2,
    1,
    1130,
    {
      effectID = 150185108,
      fireEffectID = 150185109,
      hitEffectID = 150185110,
      spawnHigh = 2,
      spawnRadius = 0.9,
      rotationTime = 250,
      flyOneTime = 50,
      hitAnimName = "Hit",
      destroyBulletDelay = 500,
      disableRoot = "arrows",
      cacheEffectCount = 4
    }
  }
}
return config, "ID", key
