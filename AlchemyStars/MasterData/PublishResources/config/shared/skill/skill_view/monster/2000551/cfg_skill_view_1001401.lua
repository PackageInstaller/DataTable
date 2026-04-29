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
      " PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=1000; PlayAudio,audioID = 7024,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=2000551; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; "
    }
  }
}
return config, "ID", key
