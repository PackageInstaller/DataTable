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
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 6013,audioType=1; PlayCasterBindEffect,effectID=PARAM.AtkEffectId; Wait,waitTime=1000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayTargetAddBuff,buffID=50001; PlayTargetAddBuff,buffID=50002; PlayCasterBindEffect,effectID=PARAM.Idle1EffectId; PlayCasterBindEffect,effectID=PARAM.Idle2EffectId; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
