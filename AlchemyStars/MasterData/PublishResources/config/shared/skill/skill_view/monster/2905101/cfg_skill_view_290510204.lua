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
    103,
    1,
    0,
    0,
    {
      boomEffectID = 290510205,
      monsterClassID = 2905101,
      startAction = "skill04-2",
      startEffectID = 290510206,
      screenEffectID = 290510209,
      centerEffectID = 290510207,
      hitAnim = "Hit",
      hitEffectID = 290510208,
      screenEffectDelayMs = 900,
      summonTrapDelayMs = 100,
      hitPlayerDelayMs = 100,
      bossShowDelayMs = 1900,
      bossShowAction = "skill04",
      bossShowEffectID = 290510210,
      finalDelayMs = 1900
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
      " PlayAudio,audioID=6280,audioType=1; "
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
