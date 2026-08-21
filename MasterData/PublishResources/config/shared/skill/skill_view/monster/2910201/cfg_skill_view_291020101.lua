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
      " PlayAudio,audioID = 290940101,audioType=1; PlayCasterVisible,visible=1; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID=291020106; PlayCasterBindEffect,effectID=291020104; PlayCasterMaterialAnim,animName=effanim_2910201_birth_m_body; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
