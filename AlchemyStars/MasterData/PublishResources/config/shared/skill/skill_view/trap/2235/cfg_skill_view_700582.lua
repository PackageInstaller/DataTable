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
      " DataSelectDamage, damageIndex = 1; PlayAudio,audioID = 3029,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1112,turnToTarget=0,deathClear=0; "
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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  }
}
return config, "ID", key
