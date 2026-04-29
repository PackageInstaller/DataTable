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
      " PlayCasterAnimation,animName = skill02; PlayDeleteCasterEffect,effectIDList=200330110; StopCasterMaterialAnim,animName=eff_2904001_skin_@crazy; DataSelectDamage,damageIndex = 1; PlayTargetMaterialAnim,animName=effanim_2003301_skill02; PlayCasterBindEffect,effectID=200330103; PlayAudio,audioID = 7062,audioType=1; Wait,waitTime=2180; DataSelectResult,effectType=85,index=1; PlayCostCasterHP; PlayCasterBindEffect,effectID=200330101; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=200330104,flyTime=400,flyTrace=1,offsety=0.4,targetPos=Hit; PlayCasterEffectAtTargetPos,bone=Root,effectID=200330102; Wait,waitTime=1500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=false; Wait,waitTime=2400; "
    }
  }
}
return config, "ID", key
