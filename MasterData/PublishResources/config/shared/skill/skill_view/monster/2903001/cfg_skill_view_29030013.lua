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
      " Wait,waitTime=700; PlayAudio,audioID = 6206,audioType=1; Wait,waitTime=300; PlayCasterAnimation,animName =Skill03; PlayCasterBindEffect,effectID=3813; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayFlyEffectCasterToTarget,flyEffectID=3814,flySpeed=200,flyTrace=3,targetPos=Hit,originalBoneName=Dummy_head,changeScaleRoot=suo1,isBlock=0,label=doEffect; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doEffect; Wait,waitTime=100; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=29030015,label=doAgain; PlayAddBuffView,buffID=29030016; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
