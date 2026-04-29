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
      " PlaySceneObjLegacyAnimation,sceneObjName=ymck_combatarm_skin,animNames=skill01_left; PlaySceneObjLegacyAnimation,sceneObjName=ymck_combatarm_skin (1),animNames=skill01_right; Wait,waitTime=1700; PlayAudio,audioID=7071,audioType=1; Wait,waitTime=100; PlaySetSceneObjVisible,sceneObjName=eff_2802901_skill01_leftline,visible=0; PlaySetSceneObjVisible,sceneObjName=eff_2802901_skill01_rightline,visible=0; PlaySetSceneObjVisible,sceneObjName=eff_2802901_skill01_leftline,visible=1; PlaySetSceneObjVisible,sceneObjName=eff_2802901_skill01_rightline,visible=1; PlayEffectAGridPos,effectID=280290103,gridPosX=5,gridPosY=5; Play2802901LaserDamage,hitEffectID=200400102,startWaitTime=0,oneGridTime=100,endtWaitTime=2000; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
