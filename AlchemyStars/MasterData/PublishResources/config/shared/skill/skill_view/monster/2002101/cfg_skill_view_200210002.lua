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
      " PlayTeleportResultTarget,type=3; PlayTeleportResultTarget,type=5; Wait,waitTime=200; PlayTeleportResultTarget,type=6; PlayTeleportResultTarget,type=9; PlayTargetVisible,visible=1,SupportBodySizeList=1&4; PlayEntityAnimation,animName=Appear,monsterClassID=2002101; Wait,waitTime=1000; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
