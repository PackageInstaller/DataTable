local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID = 160216102,audioType=1; PlayCasterBindEffect,effectID =160218103; PlayCasterBindEffect,effectID =160218104; Wait,waitTime=5000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1300,
    {
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; "
    }
  }
}
return config, "ID", key
