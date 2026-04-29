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
      " PlayAudio,audioID=6252,audioType=1; PlayHorsemanIntro,introModel=2904900.prefab,introAnimateTrigger=Birth,introMaterialAnimateName=eff_2904900_birth_xiaoshi,introEffectID=290490101,introStateTimeMs=1600,realIntroEffectID=290490102,realStateTimeMs=500,realMaterialAnimateName=eff_2904900_birth_chuxian; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; DataSelectBuff,buffIndex=1; Wait,waitTime=2000; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
