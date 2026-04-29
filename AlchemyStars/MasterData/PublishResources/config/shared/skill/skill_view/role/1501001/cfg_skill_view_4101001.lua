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
    2,
    0,
    0,
    {
      " Wait,waitTime=200; DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    100,
    {
      " DataSelectDamage,damageIndex = 1; PlayEffectRotateTrajectory,start=Target,end=Caster,effectID=2293,block=0,startWait=0,moveSpeed=600,rotateSpeed=270,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; "
    }
  }
}
return config, "ID", key
