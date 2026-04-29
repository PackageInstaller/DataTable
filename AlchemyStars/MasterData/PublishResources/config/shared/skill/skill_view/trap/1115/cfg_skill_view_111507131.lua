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
      " PlayCasterBindEffect,effectID=PARAM.Disappear; PlayCasterShowLineRenderer,show=0; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=400; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=PARAM.Appear; Wait,waitTime=200; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterShowLineRenderer,show=1; Wait,waitTime=200; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayAddHpText; Wait,waitTime=200; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
