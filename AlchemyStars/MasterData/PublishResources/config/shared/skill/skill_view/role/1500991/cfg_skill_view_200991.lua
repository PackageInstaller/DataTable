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
      " PlayCasterBindEffect,effectID =2371; PlayAudio,audioID = 2259; "
    }
  },
  {
    2,
    2,
    66,
    1,
    1,
    0,
    {
      atkAnim = "AtkChain",
      atkGridCenterEffectID = 2372,
      atkGridRandomEffect = {2370},
      centerHitDelay = 1050,
      centerDelay = 1050,
      otherGridHitDelay = 0,
      hitAnim = "Hit",
      hitEffectID = 0,
      finishDelayTime = 2500,
      distanceDelay = 50
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=2; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=492,turnToTarget=1,deathClear=0,label=zhanshatexiao; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=zhanshatexiao; "
    }
  }
}
return config, "ID", key
