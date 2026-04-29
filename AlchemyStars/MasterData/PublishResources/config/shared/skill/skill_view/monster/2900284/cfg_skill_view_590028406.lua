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
      " PlayCasterRenderState,renderState=1; PlayCasterAnimation,animName=Skill03_a; PlayCasterBindEffect,effectID=936; PlayAudio,audioID = 5005,audioType=1; Wait,waitTime=2167; PlayCasterBindEffect,effectID=937; PlayCasterBindEffect,effectID=975; PlayCasterAddBuff,buffID=30072; Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
