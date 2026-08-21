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
      " PlayCounterSpell,monsterCG =monster_2900181_draw,waitTime=1667; PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=868; PlayCasterBindEffect,effectID=869; PlayMonsterStoryTips,prob=100,tipsList=(290018102); PlayAudio,audioID=5048; Wait,waitTime=1033; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
