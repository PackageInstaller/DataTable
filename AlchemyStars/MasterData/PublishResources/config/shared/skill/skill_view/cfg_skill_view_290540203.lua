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
      " PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6297,audioType=1; PlayCasterBindEffect,effectID =290540104; PlayCasterBindEffect,effectID =290540105; Wait,waitTime=1200; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=290540202; DataSelectBuff,buffIndex=2; PlayTargetAddBuff,buffID=290540203; DataSelectBuff,buffIndex=3; PlayTargetAddBuff,buffID=290540204; DataSelectBuff,buffIndex=4; PlayTargetAddBuff,buffID=290540205; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290540106,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
