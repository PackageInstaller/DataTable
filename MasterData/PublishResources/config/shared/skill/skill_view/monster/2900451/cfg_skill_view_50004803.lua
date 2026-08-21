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
      " PlayCasterMaterialAnim,animName=PARAM.animName; PlayCasterBindEffect,effectID=PARAM.effectfog; PlayCasterRefreshBuffView,buffID=40931; PlayCasterRefreshBuffView,buffID=30123; PlayCasterRefreshBuffView,buffID=30133; PlayCasterAddBuff,buffID=40961; "
    }
  }
}
return config, "ID", key
