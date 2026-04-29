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
      " PlayAudio,audioID=7071,audioType=1; PlaySetSceneObjVisible,sceneObjName=eff_2802401_skill1_main,visible=1; PlaySceneObjLegacyAnimation,sceneObjName=qgfxcq_pt_02_skin (1),animNames=eff_2802401_skill1_hit; Wait,waitTime=500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlaySetSceneObjVisible,sceneObjName=eff_2802401_skill1_main,visible=0; "
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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=290610106,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
