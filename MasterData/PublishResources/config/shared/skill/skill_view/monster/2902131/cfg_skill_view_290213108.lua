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
      " PlayAudio,audioID =29021312,audioType=1; PlayCasterAnimation,animName = Death; Wait,waitTime=2200; PlayCasterHUDVisible,visible=0; PlayCasterVisible,visible=0; "
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
      " PlayCasterBindEffect,effectID=150213115; PlayCasterMaterialAnim,animName=effanim_2902131_death_m_body; Wait,waitTime=4500; "
    }
  }
}
return config, "ID", key
