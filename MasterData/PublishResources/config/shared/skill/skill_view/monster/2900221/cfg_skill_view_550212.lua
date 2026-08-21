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
    300,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterBindEffect,effectID=963; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=964,turnToTarget=1,deathClear=0,label=doAgain; PlayTargetAddBuff,buffID=30061; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    38,
    1,
    0,
    1000,
    {
      effectIDList = {
        966,
        819,
        823,
        965,
        962,
        963,
        960
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    3233,
    {
      " PlayTransformation; PlayCasterAddBuff,buffID=30204,remove=1; PlayCasterAddBuff,buffID=30203; PlayCasterRenderState,renderState=0; "
    }
  }
}
return config, "ID", key
