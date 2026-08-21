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
      " PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 3021,audioType=1; PlayCasterBindEffect,effectID=1102; Wait,waitTime=900; PlayEffectAtCasterPos,effectID=1103,offsetX=0.5,offsetZ=-0.5; Wait,waitTime=2000; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayAudio,audioID = 3045,audioType=1; PlayTargetBeHitEffect,hitEffectID=1104; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; Wait,waitTime=3700; "
    },
    {"", "0.5,-0.5"}
  }
}
return config, "ID", key
