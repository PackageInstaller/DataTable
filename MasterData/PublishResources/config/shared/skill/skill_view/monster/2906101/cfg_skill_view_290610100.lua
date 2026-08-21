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
      " PlayCasterVisible,visible=1; PlayTeamHUDVisible,visible=0; PlayCasterAnimation,animName=Birth; PlayCasterBindEffect,effectID =290610101; PlayCasterBindEffect,effectID =290610102; PlayAudio,audioID=7065,audioType=1; Wait,waitTime=7000; PlayCameraMoveAndReset,offset=1.25|5.25|7.25,moveTime=1000,waitTime=2000,resetTime=1000; PlayTeamHUDVisible,visible=1; "
    }
  }
}
return config, "ID", key
