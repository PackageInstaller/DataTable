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
      "PlayAudio,audioID = 2646,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 160201102; PlayCasterBindEffect,effectID = 160201103; PlayCasterBindEffect,effectID = 160201104; Wait,waitTime = 800; PlaySkillAttackRange,showTime=600,isEffectRange=0; Wait,waitTime = 3000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1250,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
