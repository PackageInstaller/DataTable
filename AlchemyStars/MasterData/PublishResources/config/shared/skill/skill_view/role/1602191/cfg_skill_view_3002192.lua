local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500841,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt1; PlayEffectAtPickUpIndexGrid,effectID=160219119,pickUpIndex=1; PlayEffectAtPickUpIndexGrid,effectID=160219119,pickUpIndex=2; PlayAudio,audioID = 160219105,audioType=1; Wait,waitTime=500; PlaySwitch2GridTrap; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
