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
      " PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=2388; Wait,waitTime=1000; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=10, onlySelf=1; PlayCasterMaterialAnim,animName=eff_2000601_skill01_main01; DataSelectResult,effectType=96,index=1; PlayTargetBindEffect,effectID=2386; Wait,waitTime=200; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; Wait,waitTime=1000; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=PARAM.buffID1; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 7017, audioType = 1}
  }
}
return config, "ID", key
