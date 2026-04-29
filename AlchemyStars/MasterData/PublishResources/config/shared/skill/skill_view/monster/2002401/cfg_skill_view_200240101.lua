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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName =birth; PlayCasterMaterialAnim,animName=effanim_2002401_birth; PlayCasterBindEffect,effectID=200240101; PlayAudio,audioID = 6256,audioType=3; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
