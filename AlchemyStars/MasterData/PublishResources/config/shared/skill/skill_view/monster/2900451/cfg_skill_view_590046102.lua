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
      " Wait,waitTime=600; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=movedown; PlayAudio,audioID = 6035,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectidle; PlayCasterBindEffect,effectID=PARAM.effectmove; PlayCasterBindEffect,effectID=PARAM.effectbirth; Wait,waitTime=2500; PlayCasterHUDVisible,visible=1; PlayCasterRefreshBuffView,buffID=30123; PlayCasterRefreshBuffView,buffID=30133; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=40931,remove=1,label=doAgainBuff; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgainBuff; PlayCasterAddBuff,buffID=40961; "
    }
  }
}
return config, "ID", key
