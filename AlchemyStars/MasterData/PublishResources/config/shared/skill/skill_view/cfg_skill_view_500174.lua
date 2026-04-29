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
      " PlayAbsorbPhantom,flyDuration=1000,eftID=657,phantomDeadAnim=Birth,phantomDeadDuration=700,eftPosYa=0.7,eftPosYb=2.4,commonEft=655; PlayAudio,audioID = 5025,audioType=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
