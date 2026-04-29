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
      " PlayCasterBindEffect,effectID=3195; PlayCasterMaterialAnim,animName=eff_2001301_idle_main; Wait,waitTime=300; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; "
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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=41041,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
