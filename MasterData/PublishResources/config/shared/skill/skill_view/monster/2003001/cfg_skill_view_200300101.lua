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
      " PlayAudio,audioID=7047,audioType=1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=500; PlayCasterBindEffect,effectID=200300101; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    550,
    {
      " DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200300102,turnToTarget=0,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    550,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    560,
    {
      "PlaySummonTrap,trapID=2003001011; "
    }
  }
}
return config, "ID", key
