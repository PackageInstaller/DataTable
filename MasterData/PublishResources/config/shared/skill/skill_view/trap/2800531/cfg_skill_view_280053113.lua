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
      " PlayCasterTrapRoundShow,visible=0; PlayCasterAnimationCleanTrigger,animName=Skill01; PlayCasterAnimationCleanTrigger,animName=Skill01_Exit; PlayCasterAnimation,animName = Skill01_Exit; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    500,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=28005313,remove=1,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    500,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=28005314,remove=1,label=doAgain1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain1; "
    }
  }
}
return config, "ID", key
