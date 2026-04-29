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
      " PlayCameraEffect,effectID=290540120; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName=Birth; Wait,waitTime=1000; PlayCasterHUDVisible,visible=1; PlayCameraChangeFov,time=2000,fov=11; PlayCameraMoveTargetPos,time=2000,pos=23|27|-20,boardCenter=-0.5|0|3.5; Wait,waitTime=2200; "
    }
  }
}
return config, "ID", key
