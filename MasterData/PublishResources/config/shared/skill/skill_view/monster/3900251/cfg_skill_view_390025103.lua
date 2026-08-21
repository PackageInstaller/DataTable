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
      " PlayCasterAnimation,animName=Skill01_aoe; PlayAudio,audioID = 5028,audioType=1; Wait,waitTime=150; PlayCasterBindEffect,effectID=651; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1000,
    {
      " DataSelectDamage,damageIndex = 1; PlayStuntMonster,monsterClassID=2900252; PlayStuntMonsterAnimation,animName=Skill01_aoe; PlayAudio,audioID = 5023,audioType=1; PlayStuntMonsterBindEffect,effectID=663; Wait,waitTime=1200; PlayStuntMonsterBindEffect,effectID=664; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=654,turnToTarget=1,deathClear=0; Wait,waitTime=1000; PlayStuntMonster,remove=1; "
    }
  }
}
return config, "ID", key
