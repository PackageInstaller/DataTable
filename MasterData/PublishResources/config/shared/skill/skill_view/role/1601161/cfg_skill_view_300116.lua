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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1601161,waitTime = 2000;"
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
      effectparam = "2576",
      castAnimationName = "AtkUlt",
      finishDelayTime = 3500,
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
    0,
    {audioID = 2326, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    1900,
    {
      " PlayFlyEffectCasterToTarget,flyEffectID = 2577,flyTime = 100,offsetx=0,offsety=3.5,offsetz=0,flyTrace = 1; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2000,
    {
      " PlaySelectCenterGridEffect,effectID=2578,intervalTime=0; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    2000,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    7,
    7,
    0,
    2,
    1,
    4000,
    {
      " PlayModifyTimeScale,type=0; "
    }
  }
}
return config, "ID", key
