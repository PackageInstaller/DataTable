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
      " PlayCounterSpell,monsterCG =monster_2900181_draw,waitTime=1667; PlayCasterAnimation,animName = Skill02; PlayMonsterStoryTips,prob=100,tipsList=(290014102); PlayCasterBindEffect,effectID=850; PlayAudio,audioID=5046; Wait,waitTime=500; PlaySummonTrap,trapID=13; Wait,waitTime=1266; "
    }
  }
}
return config, "ID", key
