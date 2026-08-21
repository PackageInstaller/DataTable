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
      " PlayCasterLegacyAnimation,animNames=eff_2800221_huode; PlayAudio,audioID = 8000,audioType=1; PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; Wait,waitTime=100; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      "DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1401,turnToTarget=1,deathClear=0, label=doAgain; Wait,waitTime=100; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      "ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; DataSelectResult,effectType=79,index=1; PlayDestroyTrap;"
    }
  }
}
return config, "ID", key
