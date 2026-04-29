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
      " PlayCasterAnimation,animName = death; PlayAudio,audioID = 7054,audioType=1; PlayCasterBindEffect,effectID=290570103; PlayCasterMaterialAnim,animName=eff_2905701_death_mat; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
