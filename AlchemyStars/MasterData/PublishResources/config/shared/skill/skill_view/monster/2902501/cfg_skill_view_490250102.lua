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
      " PlayCasterTurnToPlayer; PlayCasterAnimation,animName =Skill02; PlayAudio,audioID = 6201,audioType=1; PlayCasterSacrificeTrapsLineRenderer,casterEffectID=3686,lineEffectID=3688,lineCasterBindPos=Bip001 R Hand,lineEffectWaitTime=1000,gridEffectID=3687,gridEffectWaitTime=900,lineEffectDuration=1300; Wait,waitTime=1600; PlaySacrificeTrapVisible,visible=0; "
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
      " PlayMinosAttack,attackBeginAnimName=skill02_shoot_start,attackBeginAnimNameWaitTime=840,attackLoopAnimName=skill02_shoot_loop,attackLoopAnimNameWaitTime=150,attackWaitTime=320,attackEndAnimName=skill02_shoot_end,attackEndAnimNameWaitTime=910,lineEffectID=3690,hitEffectID=3691,attackMaxCount=20,attackEffectID=3689,PlayMinosAttackInstruction,attackAudioID=6199,attackAudioIDWaitTime=320,castLineOffsetX=0.114,castLineOffsetY=1.004,castLineOffsetZ=0.778; "
    }
  }
}
return config, "ID", key
