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
      " DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6014,audioType=1; PlayCasterBindEffect,effectID=PARAM.AtkEffectId; Wait,waitTime=1000; PlayTargetAddBuff,buffID=39004111; PlayTargetAddBuff,buffID=39004112; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=166; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayTargetAddBuff,buffID=39004111; PlayTargetAddBuff,buffID=39004112; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.Atk2EffectId,turnToTarget=1; Wait,waitTime=700; "
    }
  }
}
return config, "ID", key
