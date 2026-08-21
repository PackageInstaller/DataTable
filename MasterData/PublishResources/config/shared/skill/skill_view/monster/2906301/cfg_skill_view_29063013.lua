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
      " PlayTurnToTeleportNewPos; PlayCasterAnimation,animName = Skill03; PlayAudio,audioID=290630103,audioType=1; Wait,waitTime = 300; PlayTeleportAsMoving,time=200; PlayAllHitBack; PlayTurnToSpecifiedPos,gridX=5,gridY=5; Wait,waitTime=100; PlaySceneObjLegacyAnimation,sceneObjName=ymck_combatarm_skin,animNames=skill03_left; PlaySceneObjLegacyAnimation,sceneObjName=ymck_combatarm_skin (1),animNames=skill03_right; Wait,waitTime=2300; PlaySetSceneObjVisible,sceneObjName=eff_2906301_skill03_left,visible=0; PlaySetSceneObjVisible,sceneObjName=eff_2906301_skill03_left,visible=1; PlaySetSceneObjVisible,sceneObjName=eff_2906301_skill03_right,visible=0; PlaySetSceneObjVisible,sceneObjName=eff_2906301_skill03_right,visible=1; Wait,waitTime=200; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290630107,turnToTarget=1,deathClear=0; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
