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
    2,
    1,
    0,
    0,
    {
      effectparam = "200280101",
      castAnimationName = "Atk",
      finishDelayTime = 1800,
      buffDelayTime = 0
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 7060, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      "PlayCasterBindEffect,effectID=200280104; PlayCasterMaterialAnim,animName=effanim_2002801_skill01_main; "
    }
  },
  {
    4,
    4,
    0,
    1,
    1,
    1000,
    {
      "DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; PlayEffectAtSummonPos,effectID=200280102; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach;"
    }
  }
}
return config, "ID", key
