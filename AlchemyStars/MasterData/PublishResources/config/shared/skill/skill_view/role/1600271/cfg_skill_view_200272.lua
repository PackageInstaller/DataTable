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
      " PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 1813; PlayCasterBindEffect,effectID = 1815; PlayCasterBindEffect,effectID = 1816; Wait,waitTime = 1300; PlayCasterVisible,visible=0; Wait,waitTime = 1000; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkChain2; Wait,waitTime = 1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 3107, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    700,
    {
      " PlaySkillAttackRange,showTime=600,isEffectRange=0; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1500,
    {
      "DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1814,turnToTarget=0,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    5,
    5,
    0,
    1,
    1,
    1500,
    {
      "DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffEffectType=4100271; "
    }
  }
}
return config, "ID", key
