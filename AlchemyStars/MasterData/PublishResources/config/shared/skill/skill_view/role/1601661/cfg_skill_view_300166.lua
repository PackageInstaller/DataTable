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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1500551,waitTime = 2000; "
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
      " DataSelectResult,effectType=169,index=1; Jump,condition=CheckEffectResultIndex,param=169,goto=phaseEnd; DataSelectResult,effectType=5,index=1; Jump,condition=CheckEffectResultIndex,param=5,goto=phaseEnd; DataSelectResult,effectType=11,index=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2517,audioType=1; PlayCasterBindEffect,effectID=3858; PlayCasterBindEffect,effectID=3859; Wait,waitTime=1100; PlaySummonTrap,trapID=16016611; Wait,waitTime=1400; "
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
      " DataSelectResult,effectType=11,index=1; Jump,condition=CheckEffectResultIndex,param=11,goto=phaseEnd; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2518,audioType=1; PlayCasterBindEffect,effectID=3858; PlayCasterBindEffect,effectID=3859; Wait,waitTime=1300; PlayEffectAtPickUpGridByTrapBuffLayer, effectIDList=3861|3861|3861|3861, effectScaleList=0.45|0.45|0.65|1, trapIDList=16016611, checkBuffEffectType=40016611,dirX=0,dirY=1; Wait,waitTime=100; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectResult,effectType=5,index=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4061662,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; Wait,waitTime=1100; "
    }
  }
}
return config, "ID", key
