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
      " PlayCasterAnimation,animName = AtkUltPreview; Wait,waitTime=2100; "
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
      " PlayCasterBindEffect,effectID=1242; PlayCasterBindEffect,effectID=1243; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=3733; "
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
      " DataSelectDamage,damageIndex=1; PlayEffectAtTargetPos,effectID=1244; Wait,waitTime=2200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlaySummonTrap,trapID=14; "
    }
  }
}
return config, "ID", key
