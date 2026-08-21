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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400611,waitTime = 2000;"
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
      " PlayCasterBindEffect,effectID=3846; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2513,audioType=1; PlayEffectAtTrap,effectID=3847,trapID=15016810; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    1500,
    {
      " DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex=1; PlayAudio,audioID = 2514,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0, label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlaySummonTrap,trapID=15016810; "
    }
  }
}
return config, "ID", key
