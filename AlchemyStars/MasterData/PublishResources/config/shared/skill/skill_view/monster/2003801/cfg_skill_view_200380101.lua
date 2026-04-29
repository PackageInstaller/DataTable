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
      " PlayTeleportAsMoving,animName=SKillmove,leftAnimName=SKillmove,rightAnimName=SKillmove,time=300,notifyBuff=1,moveSetDir=1; Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
