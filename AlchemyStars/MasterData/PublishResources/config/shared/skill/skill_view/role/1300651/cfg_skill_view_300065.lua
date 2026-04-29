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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1300651,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2346,audioType=1; PlayCasterBindEffect,effectID = 2919; Wait,waitTime = 2666; PlayEffectAtCasterPos,effectID = 2920; PlayRoleTeleport, type=3; Wait,waitTime=1500; PlayRoleTeleport, type=5, onlySelf=0; PlayEffectAtCasterPos,effectID = 2921; Wait,waitTime=600; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
