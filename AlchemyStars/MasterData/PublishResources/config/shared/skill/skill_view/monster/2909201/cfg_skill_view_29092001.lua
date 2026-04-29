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
      " PlayCasterAnimation,animName = Atk01; PlayCasterBindEffect,effectID=290920111; PlayAudio,audioID=290920101,audioType=1; Wait,waitTime=900; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920112,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920112,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=29092006,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
