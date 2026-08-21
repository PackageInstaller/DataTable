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
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6179,audioType=1; Wait,waitTime=300; PlayCasterBindEffect,effectID=3414; Wait,waitTime=30; PlayCasterMaterialAnim,animName=eff_2902101_skill02_main; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3413,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayShuffleTeamOrder; "
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
      " DataSelectResult,effectType=120,index=1; PlayDestroyMonster,label=foreach; DataSelectNextResult,effectType=120; Jump,condition=CheckEffectResultIndex,param=120,goto=foreach; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
