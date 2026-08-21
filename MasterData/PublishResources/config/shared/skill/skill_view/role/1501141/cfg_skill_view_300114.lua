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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1501141,waitTime = 2000;"
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
      " PlayAudio,audioID = 2316,audioType=1;"
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
      " PlayTurnToPickUpDirection; PlayCasterAnimation,animName = AtkUlt; PlayCasterChangeMaterial,type=0,part=1,mat=eff_1501141_weaponMatAnim.mat,nodeName=1501141_weapon; PlayCasterChangeMaterial,type=0,part=1,mat=eff_1501141_weaponMatAnim.mat,nodeName=1501142_weapon; PlayCasterBindEffect,effectID=2611; PlayCasterBindEffect,effectID=2612; Wait,waitTime=200; PlayCameraEffect,effectID=2614; Wait,waitTime=5600; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2020,
    {
      " PlayChessKnightTeleport; PlayRoleTeleport, type=9; Wait,waitTime=1200; PlayCasterBindEffect,effectID =2613; Wait,waitTime=200; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1800; PlayTeleportResultTarget,type=5; PlayCasterChangeMaterial,type=1,part=1,nodeName=1501141_weapon; PlayCasterChangeMaterial,type=1,part=1,nodeName=1501142_weapon; "
    }
  },
  {
    5,
    5,
    0,
    2,
    3,
    0,
    {
      " PlayModifyTimeScale,type=0; "
    }
  }
}
return config, "ID", key
