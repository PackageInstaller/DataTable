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
      " PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=1102; Wait,waitTime=900; PlayEffectAtCasterPos,effectID=1103,offsetX=0.5,offsetZ=-0.5; Wait,waitTime=150; PlayEffectAtCasterPos,effectID=1103,offsetX=-0.5,offsetZ=-0.5; Wait,waitTime=150; PlayEffectAtCasterPos,effectID=1103,offsetX=0.5,offsetZ=0.5; Wait,waitTime=150; PlayEffectAtCasterPos,effectID=1103,offsetX=0.5,offsetZ=-0.5; Wait,waitTime=150; PlayEffectAtCasterPos,effectID=1103,offsetX=-0.5,offsetZ=-0.5; Wait,waitTime=1400; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayAudio,audioID = 3045,audioType=1; PlayTargetBeHitEffect,hitEffectID=1104; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=250; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayAudio,audioID = 3045,audioType=1; PlayTargetBeHitEffect,hitEffectID=1104; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=250; DataSelectDamage,damageIndex = 1,damageStageIndex=3; PlayAudio,audioID = 3045,audioType=1; PlayTargetBeHitEffect,hitEffectID=1104; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=250; DataSelectDamage,damageIndex = 1,damageStageIndex=4; PlayAudio,audioID = 3045,audioType=1; PlayTargetBeHitEffect,hitEffectID=1104; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=250; DataSelectDamage,damageIndex = 1,damageStageIndex=5; PlayAudio,audioID = 3045,audioType=1; PlayTargetBeHitEffect,hitEffectID=1104; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
