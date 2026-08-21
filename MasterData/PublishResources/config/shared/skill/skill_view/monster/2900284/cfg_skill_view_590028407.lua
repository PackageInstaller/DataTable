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
      " PlayCasterRenderState,renderState=1; PlayCasterAnimation,animName=Skill03_b_01; PlayCasterBindEffect,effectID=938; PlayAudio,audioID = 5004,audioType=1; PlayShowLineRenderer,show=0; Wait,waitTime=600; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=300; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName=Skill03_b_02; PlayCasterBindEffect,effectID=988; Wait,waitTime=900; PlayShowLineRenderer,show=1; PlayCasterBindEffect,effectID=937; PlayCasterBindEffect,effectID=975; PlayCasterAddBuff,buffID=30072; "
    }
  }
}
return config, "ID", key
