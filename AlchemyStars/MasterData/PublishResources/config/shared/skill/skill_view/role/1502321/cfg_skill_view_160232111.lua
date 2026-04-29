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
      " PlayAudio,audioID = 150232105,audioType=1; PlayCasterLegacyAnimation,animNames=eff_1502321_atk_gezi_out; PlayAddHpText; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4402323,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    3000,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  }
}
return config, "ID", key
