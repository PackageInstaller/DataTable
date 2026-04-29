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
      " DataSelectResult,effectType=8,index=1; Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayTargetMaterialAnim,animName=eff_2905401_skill03_out; Wait,waitTime=1800; PlayTeleportResultTarget,type=3; PlayTeleportResultTarget,type=5; PlayShowLineRenderer,show=0,selfAll=1,isTrap=1; Wait,waitTime=500; PlayTeleportResultTarget,type=6; PlayTeleportResultTarget,type=9; PlayTargetMaterialAnim,animName=eff_2905401_skill03_in; PlayShowLineRenderer,show=1,selfAll=1,isTrap=1; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayAllHitBack; PlaySpliceBoard,moveTime=1000,trapIDList=2802201|2802202|2802203|2802204,playDieSkillTrapIDList=8001721|8001722; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
