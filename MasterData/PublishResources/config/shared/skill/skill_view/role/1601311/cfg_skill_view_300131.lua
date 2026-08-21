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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1400861,waitTime = 2000; "
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
      " PlayGridDark,darkType=0; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=3193; PlayCasterBindEffect,effectID=3194; PlayAudio,audioID = 2372,audioType=1; Wait,waitTime=4800; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2900,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    4600,
    {
      "DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=3002; PlayCasterMaterialAnim,animName=common_shield; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    4600,
    {
      " PlayAddHpText; PlayGridDark,darkType=1; "
    }
  }
}
return config, "ID", key
