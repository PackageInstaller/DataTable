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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=2241; Wait,waitTime=200; DataSelectResult,effectType=8,index=1; PlayEffectAtTargetPos,effectID=1651; PlayAudio,audioID = 3068,audioType=1; PlayTeleportResultTarget,type=3; PlayTeleportResultTarget,type=5; PlayEffectAtTargetPos,effectID=1651; Wait,waitTime=100; PlayTeleportResultTarget,type=6; PlayTeleportResultTarget,type=9; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
