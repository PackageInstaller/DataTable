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
      " PlayCounterSpell,monsterCG =monster_2900141_draw,waitTime=1667; PlayCasterAnimation,animName = Skill02; PlayMonsterStoryTips,prob=100,tipsList=(290014102); PlayCasterBindEffect,effectID=842; PlayAudio,audioID=5052; Wait,waitTime=1500; DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
