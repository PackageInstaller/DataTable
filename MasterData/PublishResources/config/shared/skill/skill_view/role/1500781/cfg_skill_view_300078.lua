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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1500781,waitTime = 2000;"
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
      effectparam = "1242,1243",
      castAnimationName = "AtkUlt",
      finishDelayTime = 3733,
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
    {audioID = 3015, audioType = 1}
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " PlaySelectCenterGridEffect,effectID=1244,intervalTime=0; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    2200,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlaySummonTrap,trapID=14; "
    }
  }
}
return config, "ID", key
