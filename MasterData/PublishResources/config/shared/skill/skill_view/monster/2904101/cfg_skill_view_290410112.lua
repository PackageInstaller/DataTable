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
      " PlayCasterAnimation,animName=Skill01End; PlayCasterBindEffect,effectID=290410102; Wait,waitTime=300; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=400; PlayAudio,audioID = 6250,audioType=1; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayCasterHUDVisible,visible=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=Skill013; PlayCasterBindEffect,effectID=290410103; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role01; PlayCasterTurnToPlayer; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29041012; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6081, audioType = 1}
  }
}
return config, "ID", key
