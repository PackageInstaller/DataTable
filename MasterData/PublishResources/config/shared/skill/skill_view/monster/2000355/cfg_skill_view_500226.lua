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
      " PlayCasterEffectHolder,effHolderType=LInvincible,isShow=1; PlayCasterEffectHolder,effHolderType=RInvincible,isShow=1; PlayCasterEffectHolder,effHolderType=Invincible,isShow=1; PlayCasterEffectHolder,effHolderType=Palsy,isShow=0; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; EffectHolderLegacyAnimation,effHolderType=Permanent,animNames=eff_2900391_green; "
    }
  },
  {
    2,
    2,
    51,
    1,
    1,
    0,
    {audioID = 5062}
  },
  {
    3,
    3,
    51,
    1,
    1,
    0,
    {audioID = 5067}
  }
}
return config, "ID", key
