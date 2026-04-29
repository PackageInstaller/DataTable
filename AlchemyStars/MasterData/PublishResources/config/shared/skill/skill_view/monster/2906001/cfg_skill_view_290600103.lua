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
      " PlayAudio,audioID = 290600119,audioType=1; PlayTurnToTeleportNewPos; PlayCasterAnimation,animName =skill01_move1; PlayEffectTeleportOldPos,effectID=290600104,useTeleportDir=1; Wait,waitTime=500; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayCasterTurnToPlayer; Wait,waitTime=100; PlayEffectTeleportNewPos,effectID=290600105,useTeleportDir=1; Wait,waitTime=100; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName =skill01_move2; Wait,waitTime=1100; PlayCasterAnimation,animName =skill01_atk; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime = 1000; "
    }
  }
}
return config, "ID", key
