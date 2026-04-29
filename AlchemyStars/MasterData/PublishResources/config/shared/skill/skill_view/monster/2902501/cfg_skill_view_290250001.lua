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
      " PlayCasterAnimation,animName = Birth; PlayCasterBindEffect,effectID=3663; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAttachEffectHolder,effHolderType=ChangeMi,effId=3662; PlayCasterEffectHolder,effHolderType=ChangeMi,isShow=0; PlayAudio,audioID = 6197,audioType=1; Wait,waitTime=1200; "
    }
  }
}
return config, "ID", key
