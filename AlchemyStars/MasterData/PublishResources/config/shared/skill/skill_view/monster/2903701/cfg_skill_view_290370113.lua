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
      " PlayTeleportAsMoving,time=667,leftAnimName=move01,rightAnimName=move02; PlayAudio,audioID =6213,audioType=1; "
    }
  },
  {
    2,
    2,
    34,
    1,
    0,
    0,
    {
      showTimeDelay = 0,
      gridEffectID = 480,
      gridEffectDelayTime = 0,
      gridIntervalTime = 0
    }
  }
}
return config, "ID", key
