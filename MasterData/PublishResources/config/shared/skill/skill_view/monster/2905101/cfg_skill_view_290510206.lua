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
      " PlayCasterAnimation,animName=skill05-2; PlayCasterBindEffect,effectID=290510115; PlayCasterMaterialAnim,animName=effanim_2905102_death; PlayCasterBindEffect,effectID=290510117; PlayCasterHUDVisible,visible=0; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayAudio,audioID=6214,audioType=1; DataSelectResult,effectType=120,index=1; PlayDestroyMonster; Wait,waitTime=3300; "
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
      " PlayAudio,audioID=6281,audioType=1; "
    }
  }
}
return config, "ID", key
