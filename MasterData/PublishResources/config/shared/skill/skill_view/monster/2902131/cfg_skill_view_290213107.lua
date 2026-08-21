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
      " PlayAudio,audioID = 29021311,audioType=1; PlayCameraEffect,effectID=150213114; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = Birth; PlayCasterMaterialAnim,animName=effanim_2902131_birth_m_wp; PlayCasterMaterialAnim,animName=effanim_2902131_birth_m_body; PlayCasterBindEffect,effectID=150213113; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
