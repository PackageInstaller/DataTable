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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1400621,waitTime = 2000;"
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
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID = 150185103; Wait,waitTime=260; PlayTeleportAsMoving,speed=33; PlayRoleTeleport,type=9; PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0,useResultPosCalcDir=1; PlayCasterAnimation,animName=AtkUlt3; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    0,
    {audioID = 2599, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    100,
    {
      " PlayCasterToPickupTrajectory,effectID=150185105,flyTime=800; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
