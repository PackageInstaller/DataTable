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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400481,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    2,
    2,
    1,
    0,
    {
      effectparam = "50100",
      castAnimationName = "AtkUlt",
      finishDelayTime = 0,
      buffDelayTime = 0,
      buffNeedImmediatelyEffect = 0,
      rotateToCenter = 1
    }
  },
  {
    3,
    3,
    43,
    2,
    1,
    66,
    {audioID = 3041, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    900,
    {
      " PlayFlyEffectCasterToTarget,flyEffectID = 105500,flyTime = 150,flyTrace = 1,originalBoneName= Bone070,targetPos= EffectSlot; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1050,
    {
      " PlaySelectCenterGridEffect,effectID=50302,intervalTime=0; Wait,waitTime=1150; PlaySelectCenterGridEffect,effectID=5030100,intervalTime=0; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=50300,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    2300,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=50300,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
