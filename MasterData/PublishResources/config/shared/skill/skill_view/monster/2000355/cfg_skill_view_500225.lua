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
      " PlayAudio,audioID = 5060,audioType=1; PlayCasterEffectHolder,effHolderType=LInvincible,isShow=0; PlayCasterEffectHolder,effHolderType=RInvincible,isShow=0; PlayCasterEffectHolder,effHolderType=Invincible,isShow=0; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; PlayCasterEffectHolder,effHolderType=Palsy,isShow=1; EffectHolderLegacyAnimation,effHolderType=Permanent,animNames=eff_2900391_red01; "
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
      "PlayDeleteWaringArea;"
    }
  },
  {
    3,
    3,
    38,
    1,
    1,
    0,
    {
      effectIDList = {339}
    }
  }
}
return config, "ID", key
