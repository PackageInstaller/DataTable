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
    1,
    1,
    0,
    0,
    {
      castEffectID = 3733,
      castAnimation = "Atk",
      castLongAnimation = "Atk_Long",
      atkEffectDelay = 0,
      longAtkEffectDelay = 100,
      hitPointDelay = 100,
      longHitPointDelay = 210,
      onHitAnimation = "Hit",
      hitEffectID = 3734,
      castTotalTime = 333,
      longCastTotalTime = 500,
      hpDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {
      audioID = 2490,
      atkSoundDelay = 0,
      longAtkSoundDelay = 100,
      audioType = 1
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    100,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4001621,label=doAgain; PlayTargetAddBuff,buffID=4001623; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
