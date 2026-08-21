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
      " PlayCasterVisible,visible=1; PlayCasterLegacyAnimation,animNames=eff_2908901_skill_01_born; PlayAudio,audioID = 290890102,audioType=1; DataSelectResult,effectType=5,index=1; PlayTargetAddBuff,buffID=28089011,label=goo; PlayTargetAddBuff,buffID=28089012; PlayTargetAddBuff,buffID=28089010; DataSelectNextResult,effectType=5; Jump,condition=CheckEffectResultIndex,param=5,goto=goo; Wait,waitTime=2100; PlayCasterLegacyAnimation,animNames=eff_2908901_skill_01_idle; "
    }
  }
}
return config, "ID", key
