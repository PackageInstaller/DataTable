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
      " PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=290360102; PlayCasterBindEffect,effectID=290360103; PlayAudio,audioID=6165,audioType=1; Wait,waitTime=1500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=29036013,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
