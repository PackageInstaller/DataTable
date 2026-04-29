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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600111,waitTime = 2000;"
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
      "PlayAudio,audioID = 2253,audioType=1;"
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=2256; Wait,waitTime=550; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5; PlayEffectAtCasterPos, effectID=2257; Wait,waitTime=50; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayTurnToTeleportOldPos; PlayCasterAnimation,animName = AtkUlt2; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    750,
    {
      " DataSelectScopeGridRange; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=2258,label=playRangeEffect; Wait,waitTime=25; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    81,
    2,
    1,
    1200,
    {
      trajectoryCount = 20,
      effectID = 2259,
      startWait = 600,
      moveSpeed = 400,
      rotateSpeed = 210,
      sphereRadius = 4,
      turnToTarget = 1,
      hitAnimName = "Hit",
      hitEffectID = 2260,
      intervalTime = 100,
      random = 1,
      randomPercent = 10,
      hitSoundID = 2254
    }
  }
}
return config, "ID", key
