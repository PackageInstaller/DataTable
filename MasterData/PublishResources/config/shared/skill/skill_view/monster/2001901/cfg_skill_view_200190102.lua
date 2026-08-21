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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID =7011,audioType=1; PlayCasterBindEffect,effectID=200190105; DataSelectDamage,damageIndex=1; PlayEffectAtTargetPos,effectID=200190106; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3827,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
