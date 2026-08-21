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
      " PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 5078,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill02EffectId; Wait,waitTime=1600; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0;PlayTargetAddBuff,buffID=50001; PlayTargetAddBuff,buffID=50001; PlayTargetAddBuff,buffID=50001; PlayTargetAddBuff,buffID=50002; PlayTargetAddBuff,buffID=50002; PlayTargetAddBuff,buffID=50002; "
    }
  }
}
return config, "ID", key
