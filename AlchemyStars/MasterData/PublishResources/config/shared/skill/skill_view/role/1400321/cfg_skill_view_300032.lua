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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400321,waitTime = 2000;"
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
      "PlayAudio,audioID = 2118,audioType=1;"
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =461; Wait,waitTime=2900; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    1200,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=460,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Wait,waitTime=200; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
