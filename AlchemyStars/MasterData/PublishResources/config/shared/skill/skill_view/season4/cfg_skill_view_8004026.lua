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
      " PlayAudio,audioID=290620104,audioType=1; PlayCasterLegacyAnimation,animNames=eff_2906201_passive02_gezi_out|eff_2906201_passive02_gezi_in; PlayFixTrapWall; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
