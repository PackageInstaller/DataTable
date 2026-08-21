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
      " PlayCasterAnimation,animName = CallIn; PlayCasterAttachmentAnimation,animName = CallIn; PlayAudio,audioID=6154,audioType=1; Wait,waitTime=2000; "
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
      " PlayCasterAnimation,animName = CallOut; PlayAddAttachment,attachResName=2901501; PlayCasterAttachmentVisible,visible=1; PlayCasterAttachmentAnimation,animName = CallOut; PlayCasterBindEffect,effectID=3322; PlayAudio,audioID=6150,audioType=1; Wait,waitTime=900; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3323,turnToTarget=1,deathClear=0; Wait,waitTime=1500; "
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
      " PlayIncreaseSan; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=2000612,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
