local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601451,waitTime = 2000;"
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
      " PlayTurnToTeleportNewPos; Wait,waitTime=50; PlayEffectAtCasterPos,effectID=3506; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; PlayAudio,audioID = 2427,audioType=1; Wait,waitTime=250; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName = AtkUlt03; PlayEffectAtCasterPos,effectID=3507; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
