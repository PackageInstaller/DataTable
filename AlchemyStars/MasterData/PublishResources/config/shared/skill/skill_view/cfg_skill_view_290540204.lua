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
      " PlayCasterBindEffect,effectID=290380105; Wait,waitTime=800; PlayAudio,audioID=6298,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,turnToTarget=1,deathClear=0; "
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
      " DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; Wait,waitTime=100; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach; "
    }
  }
}
return config, "ID", key
