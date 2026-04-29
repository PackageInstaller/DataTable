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
      "PlayCasterBindEffect,effectID=290600115; PlayCasterAnimation,animName =skill05; DataSelectResult,effectType=5,index=1; PlayFlyEffectCasterToTarget,flyEffectID=290600118,flyTime=500,flyTrace=1,isBlock=0,caster=Target,target=Caster,label=goo; PlayTargetAddBuff,buffID=290600101; PlayTargetMaterialAnim,animName=eff_2000602_skill05_healing_mat; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=goo; Wait,waitTime=1000; PlayCasterMaterialAnim,animName=eff_2906001_skill05_mat; PlayAddHpText;"
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
      " PlayAudio,audioID = 3022,audioType=1; PlayTurnToTeleportNewPos; PlayCasterAnimation,animName =skill01_move1; PlayCasterBindEffect,effectID=290600104; Wait,waitTime=500; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayCasterTurnToPlayer; Wait,waitTime=100; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName =skill01_move2; PlayCasterBindEffect,effectID=290600105; Wait,waitTime=1100; PlayCasterAnimation,animName =skill01_atk; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    1500,
    {
      " DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=290600106,label=hitAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=hitAgain;"
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    2550,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 2000; "
    }
  },
  {
    5,
    5,
    0,
    2,
    4,
    0,
    {
      "PlayCasterBindEffect,effectID=290600101; PlayCasterAnimation,animName =skill03; DataSelectResult,effectType=5,index=1,damageStageIndex=2; PlayTargetAddBuff,buffID=291600103,label=go2; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=go2; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
