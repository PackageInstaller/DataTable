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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=2242; PlayAudio,audioID = 3068,audioType=1; Wait,waitTime=200; DataSelectResult,effectType=8,index=1; PlayTeleportResultTarget,type=3; PlayTeleportResultTarget,type=5; PlayEffectAtTargetPos,effectID=2328; Wait,waitTime=100; PlayTeleportResultTarget,type=6; PlayTeleportResultTarget,type=9; PlayEffectAtTargetPos,effectID=2329; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
