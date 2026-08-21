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
      " PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName = Skill02; PlayCasterMaterialAnim,animName=eff_2000601_skill02_root; PlayDetachMonster; PlayCasterBindEffect,effectID=2389; PlayCasterBindEffect,effectID=2390; PlayCasterBindEffect,effectID=2391; Wait,waitTime=2000; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=2000603; PlayTargetAddBuff,buffID=10011; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 7018, audioType = 1}
  }
}
return config, "ID", key
