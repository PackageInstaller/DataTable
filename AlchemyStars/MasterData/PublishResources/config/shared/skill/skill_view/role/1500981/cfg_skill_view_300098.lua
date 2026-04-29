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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1500981,waitTime = 2000; "
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2268; PlayAudio,audioID = 2257,audioType=1; Wait,waitTime=4000; "
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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; Jump,condition=CheckTargetIsCanMove,result=0,goto=canmove; PlayEffectAtTargetPos,effectID=2269; Wait,waitTime=1000; PlayTargetVisible,visible=0,SupportBodySizeList=1&4; PlayTeleportResultTarget,type=3; Wait,waitTime=300; PlayEffectAtTargetPos,effectID=2266; PlayTeleportResultTarget,type=5; Wait,waitTime=1000; PlayEffectAtTargetPos,effectID=2267; Wait,waitTime=1300; PlayTeleportResultTarget,type=6; PlayTargetVisible,visible=1,SupportBodySizeList=1&4; PlayTeleportResultTarget,type=9; DataSelectDamage,damageIndex = 1,damageStageIndex=1,label=canmove; Jump,condition=CheckTargetIsCanMove,goto=boom2; PlayEffectAtTargetPos,effectID=2269; Wait,waitTime=1000; PlayTargetVisible,visible=0,SupportBodySizeList=1&4; Wait,waitTime=300; PlayEffectAtTargetPos,effectID=2266; Wait,waitTime=1000; PlayEffectAtTargetPos,effectID=2267; Wait,waitTime=1300; PlayTargetVisible,visible=1,SupportBodySizeList=1&4; DataSelectDamage,damageIndex = 1,damageStageIndex=2,label=boom2; Jump,condition=CheckDamageIndexValid,goto=boom0; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayEffectAtTargetPos,effectID=2264; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 1,damageStageIndex=2,label=boom0; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayEffectAtTargetPos,effectID=2265; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1300; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2261,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
