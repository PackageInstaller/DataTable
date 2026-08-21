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
      " PlayEntityAnimation,animName=Skill02,trapID=2800301; PlayEntityBindEffect,effectID=2656,trapID=2800301; PlayEntityAnimation,animName=Skill02,trapID=2800302; PlayEntityBindEffect,effectID=2656,trapID=2800302; PlayEntityAnimation,animName=Skill02,trapID=2800305; PlayEntityBindEffect,effectID=2656,trapID=2800305; PlayEntityAnimation,animName=Skill02,trapID=2800306; PlayEntityBindEffect,effectID=2656,trapID=2800306; PlayEntityAnimation,animName=Skill02,trapID=2800307; PlayEntityBindEffect,effectID=2656,trapID=2800307; PlayEntityAnimation,animName=Skill02,trapID=2800308; PlayEntityBindEffect,effectID=2656,trapID=2800308; PlayEntityAnimation,animName=Skill02,trapID=2800321; PlayEntityBindEffect,effectID=2656,trapID=2800321; PlayEntityAnimation,animName=Skill02,trapID=2800322; PlayEntityBindEffect,effectID=2656,trapID=2800322; PlayEntityVisible,visible=1,trapID=2800309; PlayEntityAnimation,animName=Skill02_2,trapID=2800309; PlayEntityBindEffect,effectID=2655,trapID=2800309; PlayEntityBindEffect,effectID=2656,trapID=2800309; PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=2644; PlayAudio,audioID = 6108,audioType=1; Wait,waitTime=1800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1200; PlayEntityVisible,visible=0,trapID=2800309; "
    }
  }
}
return config, "ID", key
