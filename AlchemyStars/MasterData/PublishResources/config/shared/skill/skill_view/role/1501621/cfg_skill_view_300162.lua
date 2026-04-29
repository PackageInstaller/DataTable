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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601341,waitTime = 2000;"
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
      " PlayPlayerRotateToPickup; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2492,audioType=1; PlayCasterBindEffect,effectID = 3737; Wait,waitTime=800; PlayCasterBindEffect,effectID = 3738; Wait,waitTime=2000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2150,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    2150,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4001624,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
