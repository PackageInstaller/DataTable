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
      " PlayEffectAGridPos,effectID=1379,gridPosX=3,gridPosY=7; PlayAudio,audioID = 6037,audioType=1; Wait,waitTime=800; PlayCasterVisible, visible=1; PlayCasterAnimation,animName = Birth; Wait,waitTime=6000; "
    }
  }
}
return config, "ID", key
