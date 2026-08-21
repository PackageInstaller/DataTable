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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayAudio,audioID = 6116,audioType=1; PlayEffectAGridPos,effectID=3044,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; Wait,waitTime=500; PlaySummonTrap,trapID=60,effectID=PARAM.effectID3; "
    }
  }
}
return config, "ID", key
