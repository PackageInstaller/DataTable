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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160153308; PlayCameraEffect,effectID=160153310,casterEffectHolder=1; PlayAudio,audioID = 160153301,audioType=1; Wait,waitTime=4500; PlayModifyTimeScale,type=0; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    60,
    1,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160153309
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1300,
    {
      " ScreenShotSetTextureNormal,effectName=eff_1601533_atkchain_came,duration=2500,block=0,rootName=came,textureName=_SceneTex,casterEffectHolderEffectID=160153310; ScreenShotSetTextureNormal,effectName=eff_1601533_atkchain_came,duration=2500,block=0,rootName=Object008_frag_090,textureName=_SceneTex,casterEffectHolderEffectID=160153310; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
