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
      " Wait,waitTime=300; PlayAudio,audioID=6127,audioType=1; PlayGridDark,darkType=0; PlayCasterBindEffect,effectID=3161; Wait,waitTime=500; PlayCasterBindEffect,effectID=3160; PlayCasterAnimation,animName = birth; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=300; PlayEffectAGridPos,effectID=3170,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; PlayGridDark,darkType=1; "
    }
  }
}
return config, "ID", key
