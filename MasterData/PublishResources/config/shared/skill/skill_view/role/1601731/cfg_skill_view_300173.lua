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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600141,waitTime = 2000; "
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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 6201,audioType=1; PlayCasterSacrificeTrapsLineRenderer, casterEffectID=160173106, lineEffectID=160173108, lineCasterBindPos=Bip001 R Hand, lineEffectWaitTime=1000, gridEffectID=160173107, gridEffectWaitTime=900, lineEffectDuration=1300; Wait,waitTime=3500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    2140,
    {
      " PlayPetSacrificeTrapVisible,visible=0; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    10,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
