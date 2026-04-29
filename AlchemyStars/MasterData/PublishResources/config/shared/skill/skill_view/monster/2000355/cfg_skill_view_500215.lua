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
      " PlayCasterAttachEffectHolder,effHolderType=Idle,effId=768; PlayCasterAttachEffectHolder,effHolderType=Charge,effId=769; PlayCasterAttachEffectHolder,effHolderType=LInvincible,effId=770,T=2.75|0|3.2; PlayCasterAttachEffectHolder,effHolderType=RInvincible,effId=770,T=-2.25|0|3.2; PlayCasterAttachEffectHolder,effHolderType=Invincible,effId=770,T=0|0|3.2,S=1.2|1.2|1.2; PlayCasterAttachEffectHolder,effHolderType=Palsy,effId=771; PlayCasterAttachEffectHolder,effHolderType=Permanent,effId=767; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; PlayCasterEffectHolder,effHolderType=Charge,isShow=0; PlayCasterEffectHolder,effHolderType=LInvincible,isShow=1; PlayCasterEffectHolder,effHolderType=RInvincible,isShow=1; PlayCasterEffectHolder,effHolderType=Invincible,isShow=1; PlayCasterEffectHolder,effHolderType=Palsy,isShow=0; PlayCasterEffectHolder,effHolderType=Permanent,isShow=1; EffectHolderLegacyAnimation,effHolderType=Permanent,animNames=eff_2900391_green; PlayMonsterStoryTips,prob=100,tipsList=(290039101); "
    }
  },
  {
    2,
    2,
    51,
    1,
    1,
    0,
    {audioID = 5062}
  },
  {
    3,
    3,
    51,
    1,
    1,
    0,
    {audioID = 5067}
  },
  {
    4,
    4,
    0,
    1,
    1,
    0,
    {
      " Wait,waitTime=500; PlayCasterAnimation,animName=Grenade; PlayCasterEffectHolder,effHolderType=Idle,isShow=0; PlayCasterBindEffect,effectID=774; PlayAudio,audioID = 5063,audioType=1; DataSelectSummonThing,index=1; PlayCasterBindEffect,effectID=773,label=redoFire; Wait,waitTime=140; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoFire; Wait,waitTime=500; DataSelectSummonThing,index=1; PlayEffectAtSummonPos,effectID=772,label=redoBomb; Wait,waitTime=140; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoBomb; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; Wait,waitTime=140; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; PlayCasterEffectHolder,effHolderType=Idle,isShow=1; "
    }
  }
}
return config, "ID", key
