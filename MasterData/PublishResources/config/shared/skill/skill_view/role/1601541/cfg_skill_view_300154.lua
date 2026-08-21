local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401371,waitTime = 2000;"
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
      " PlayAudio,audioID = 2465,audioType=1; DataSelectResult,effectType=151,index=1; PlayCasterTurnToTarget; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=3589; Wait,waitTime=500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    660,
    {
      " DataSelectResult,effectType=151,index=1; PlayMultiJumpEffectToTarget,flyEffectID=3587,flyTime=340,startOffsetX=-0.15,startOffsetY=1.25,startOffsetZ=0.5,targetOffsetX=-2,targetOffsetZ=0,jumpPower=1.6; PlayMultiJumpEffectToTarget,flyEffectID=3587,flyTime=340,startOffsetX=-0.15,startOffsetY=1.25,startOffsetZ=0.5,targetOffsetX=2,targetOffsetZ=0,jumpPower=1.6; PlayMultiJumpEffectToTarget,flyEffectID=3587,flyTime=340,startOffsetX=-0.15,startOffsetY=1.25,startOffsetZ=0.5,targetOffsetX=0,targetOffsetZ=-2,jumpPower=1.6; PlayMultiJumpEffectToTarget,flyEffectID=3587,flyTime=340,startOffsetX=-0.15,startOffsetY=1.25,startOffsetZ=0.5,targetOffsetX=0,targetOffsetZ=2,jumpPower=1.6; Wait,waitTime=340; PlayTargetBindEffect,effectID=3588; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    870,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=400154,stageIndex=1,label=doAgain; PlayTargetAddBuff,buffID=400154,stageIndex=2,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
