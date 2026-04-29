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
      " PlayCasterLegacyAnimation,animNames=eff_2801101_huode;DataSelectBuff,buffIndex=1;PlayTargetAddBuff,buffID=2801101,label=doAgain;DataSelectNextBuff;Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    633,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayAudio,audioID =6218,audioType=1; "
    }
  }
}
return config, "ID", key
