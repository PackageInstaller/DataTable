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
    38,
    1,
    0,
    0,
    {
      effectIDList = "PARAM.RemoveEffect"
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterAnimation,animName = Skill04; PlayAudio,audioID =6017,audioType=1; PlayCasterBindEffect,effectID=PARAM.Skill04EffectId; PlayTargetAddBuff,buffID=50004; DataSelectDamage,damageIndex = 1; PlayEffectAtTargetPos,effectID=PARAM.Skill04HitEffectId; Wait,waitTime=4200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayTargetAddBuff,buffID=50001,remove=1; PlayTargetAddBuff,buffID=50002,remove=1; PlayCasterBindEffect,effectID=PARAM.Idle1EffectId; PlayCasterBindEffect,effectID=PARAM.Idle2EffectId; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
