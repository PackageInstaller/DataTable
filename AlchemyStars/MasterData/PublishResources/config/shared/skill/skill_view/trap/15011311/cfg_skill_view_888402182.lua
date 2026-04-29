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
      " DataSelectResult,effectType=64,index=1; PlaySummonTrap,trapID=791,label=foreach; DataSelectNextResult,effectType=64; Jump,condition=CheckEffectResultIndex,param=64,goto=foreach; PlayTrapAreaOutline,effectID=3601,trapType=17; PlayAudio,audioID=6195,audioType=1; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
