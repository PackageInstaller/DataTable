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
      " PlayAudio,audioID = 290580102,audioType=1; PlayCasterBindEffect,effectID=290580103; PlayCasterAnimation,animName=Teleport_1; Wait,waitTime=133; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=500; PlayCasterAnimation,animName=Teleport_2; PlayCasterBindEffect,effectID=290580103; PlayRoleTeleport,type=6, onlySelf=1; PlayChangeBodyArea; PlayAllHitBack; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
