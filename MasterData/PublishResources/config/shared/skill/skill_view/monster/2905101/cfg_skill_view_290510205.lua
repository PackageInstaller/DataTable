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
    104,
    1,
    0,
    0,
    {
      monsterClassID = 2905101,
      startAction = "skill05-2",
      startEffectID = 290510117,
      mainEffectID = 290510115,
      startMatAnim = "effanim_2905102_death",
      bossShowDelayMs = 2300,
      bossShowAction = "skill04",
      bossShowEffectID = 290510118,
      finalDelayMs = 2000
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
      " Wait,waitTime=200; PlayAudio,audioID=6281,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlaySummonTrap,trapID=2905111; PlaySummonTrap,trapID=2905112; Wait,waitTime=200; "
    }
  }
}
return config, "ID", key
