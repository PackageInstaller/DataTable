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
      " PlayCasterAnimation,animName=Skill01_0; Wait,waitTime=300; PlayCasterBindEffect,effectID=3118; Wait,waitTime=215; Wait,waitTime=385; PlayRoleTeleport,type=3, onlySelf=1; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayCasterHUDVisible,visible=0; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=3119; Wait,waitTime=410; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill01_1; PlayCasterMaterialAnim,animName=eff_2900681_birth_main; Wait,waitTime=300; PlayCasterControlGridDown,enable=1; PlayCasterControlOutLine,enable=1; PlayCasterHUDVisible,visible=1; "
    }
  }
}
return config, "ID", key
