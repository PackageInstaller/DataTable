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
      " PlayAudio,audioID=7066,audioType=1; PlayCasterAnimation,animName=Death; PlayCasterBindEffect,effectID =290610103; PlayCasterHUDVisible,visible=0; Wait,waitTime=2000; PlayCasterMaterialAnim,animName=monster_death_dark; PlayCasterBindEffect,effectID =1059; "
    }
  }
}
return config, "ID", key
