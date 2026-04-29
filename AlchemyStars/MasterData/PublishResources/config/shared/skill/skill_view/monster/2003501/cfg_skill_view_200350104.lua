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
      " PlayAudio,audioID=20035014,audioType=1; PlayCasterMaterialAnim,animName=effanim_2003501_skil04; PlayCasterAnimation,animName=Skill04; PlayCasterBindEffect,effectID=200350107; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    600,
    {
      " PlayAddHpText; "
    }
  }
}
return config, "ID", key
