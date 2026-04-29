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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName = birth; PlayCasterBindEffect,effectID= 290990104; PlayCasterMaterialAnim,animName=eff_2909901_birth_in; PlayAudio,audioID=29099011,audioType=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
