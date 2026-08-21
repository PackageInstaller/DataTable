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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600961,waitTime = 2000;"
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
      " PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2245,audioType=1; PlayCasterBindEffect,effectID=2397; Wait,waitTime=2260; PlayCasterVisible,visible=0; Wait,waitTime=240; PlaySelectCenterGridEffect,effectID=2400,isFacingMonsterOnGrid=1,intervalTime=0; Wait,waitTime=3100; PlaySelectCenterGridEffect,effectID=2398,intervalTime=0; Wait,waitTime=1100; PlayEffectAtCasterPos, effectID=2399; Wait,waitTime=800; PlayCasterVisible,visible=1; PlayCasterAnimation,animName=AtkUlt2; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    4830,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=5400; "
    }
  }
}
return config, "ID", key
