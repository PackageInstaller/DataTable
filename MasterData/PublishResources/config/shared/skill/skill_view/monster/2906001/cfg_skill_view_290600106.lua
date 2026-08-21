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
      "PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; PlayAudio,audioID = 290600118,audioType=1; DataSelectResult,effectType=5,index=1; PlayFlyEffectCasterToTarget,flyEffectID=290600118,flyTime=500,flyTrace=1,isBlock=0,caster=Target,target=Caster,label=goo; PlayTargetAddBuff,buffID=290600101; PlayTargetMaterialAnim,animName=eff_2000602_skill05_healing_mat; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=goo; Wait,waitTime=1000; PlayCasterMaterialAnim,animName=eff_2906001_skill05_mat; PlayAddHpText; "
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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName =skill04; PlayAudio,audioID = 290600122,audioType=1; PlayCasterBindEffect,effectID=290600109; PlayCasterBindEffect,effectID=290600110; PlayTargetBeHitEffect,hitEffectID=290600111; Wait,waitTime=4000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      "PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; DataSelectResult,effectType=5,index=1,damageStageIndex=2; PlayTargetAddBuff,buffID=290600106,label=go2; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=go2; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
