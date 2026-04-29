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
      " PlayAudio,audioID = 160227102,audioType=1; "
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
      " Jump,condition=CheckDamageSkillResultTargetCount,param=2|1|5,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayCasterAnimation,animName = AtkChain1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID =160227101; Wait,waitTime=800; PlayTargetBindEffect,effectID=160227103; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=420227101; PlayTargetAddBuff,buffID=420227102; PlayTargetAddBuff,buffID=420227103; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " Jump,condition=CheckDamageSkillResultTargetCount,param=6|1|5,goto=phaseEnd; DataSelectBuff,buffIndex=1; PlayCasterAnimation,animName = AtkChain1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID =160227101; PlayCasterBindEffect,effectID =160227102; Wait,waitTime=800; PlayTargetBindEffect,effectID=160227103; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=420227101; PlayTargetAddBuff,buffID=420227102; PlayTargetAddBuff,buffID=420227103; Wait,waitTime=1200; DataSelectBuff,buffIndex=2; PlayAudio,audioID = 160227102,audioType=1; PlayCasterAnimation,animName = AtkChain2; PlayCasterTurnToTarget; Wait,waitTime=500; PlayTargetBindEffect,effectID=160227103; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=420227101; PlayTargetAddBuff,buffID=420227102; PlayTargetAddBuff,buffID=420227103; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
