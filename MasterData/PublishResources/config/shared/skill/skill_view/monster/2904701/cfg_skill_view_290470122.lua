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
      " PlayCasterAnimation,animName = skill02; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID = 6268,audioType=1; Wait,waitTime=500; DataSelectResult,effectType=67,index=1; Jump,condition=CheckEffectResultIndex,param=67,result=0,goto=phaseEnd; DataSelectDamage,damageIndex=1; PlayHookTractionTarget,hookEffectID=PARAM.effectID2,chainEffectID=290470107,ChainBeginName=weapon01,hookUnitGridTime=70,tractionUnitGridTime=70,hitAnimName=Hit,hitEffectID=PARAM.effectID3,turnToTarget=1,deathClear=0,moveSpeed=9; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
