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
    101,
    1,
    0,
    0,
    {
      startAction = "skill02",
      downAction = "skill02-2",
      lineEffectID = 290510107,
      lineEffectCasterBone = "2905101_bone00",
      lineEffectTrapBone = "gezi",
      upTailEffectID = 290510108,
      downTailEffectID = 290510109,
      landEffectID = 290510106,
      upEffAnim = "effanim_2905101_skill2_up",
      downEffAnim = "effanim_2905102_skill2_down",
      showDropDelay = 1200,
      landDelay = 200
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlayDeleteCasterEffect,effectIDList=290510102; PlayAudio,audioID=6278,audioType=1; Wait,waitTime=1600; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290510110,turnToTarget=1,deathClear=0; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
