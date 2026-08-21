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
      " Wait,waitTime=200; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayAudio,audioID = 6012,audioType=1; PlayCasterBindEffect,effectID=PARAM.BirthEffectId; PlayCasterBindEffect,effectID=PARAM.Idle1EffectId; PlayCasterBindEffect,effectID=PARAM.Idle2EffectId; Wait,waitTime=4500; "
    }
  }
}
return config, "ID", key
