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
      " PlayTeamBindEffect,effectID =58,mode=1; Wait,waitTime=100; PlayTeleportResultTarget,type=3; PlayTeleportResultTarget,type=5; Wait,waitTime=500; PlayTeleportResultTarget,type=6; PlayTeleportResultTarget,type=9; PlayTeamBindEffect,effectID =58,mode=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
