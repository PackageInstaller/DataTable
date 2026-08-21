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
      " PlayCounterSpell,monsterCG =monster_2900141_draw,waitTime=1667; PlayMonsterStoryTips,prob=100,tipsList=(290018102); PlayCasterAnimation,animName = Skill02; PlayCasterBindEffect,effectID=858; PlayAudio,audioID=5054; Wait,waitTime=700; PlaySummonTrap,trapID=12; Wait,waitTime=700; "
    }
  }
}
return config, "ID", key
