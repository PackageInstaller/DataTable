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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID =1400411,waitTime =2000; "
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
      " PlayAudio,audioID = 3067,audioType=1; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=2241; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =1650; PlayCasterBindEffect,effectID =1652; Wait,waitTime=2400; PlaySummonTrap,trapID=2241; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=500; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName = AtkUlt1; Wait,waitTime=100; PlayCasterBindEffect,effectID =1653; Wait,waitTime=1800; "
    }
  }
}
return config, "ID", key
