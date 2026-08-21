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
      " PlayAudio,audioID=7070,audioType=1; PlayCasterAnimation,animName=Skill04; PlayCasterBindEffect,effectID =290610113; PlayCasterBindEffect,effectID =290610114; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1900; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; Jump,condition=CheckTargetHPAndSceneState,param=1|2802402|50,result=0,goto=phaseEnd; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_01,visible=0; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_02,visible=1; "
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
      " Jump,condition=CheckTargetHPAndSceneState,param=2|2802402|0,result=0,goto=phaseEnd; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_02,visible=0; PlaySetSceneObjVisible,sceneObjName=qgfxcq_gate_03,visible=1; "
    }
  }
}
return config, "ID", key
