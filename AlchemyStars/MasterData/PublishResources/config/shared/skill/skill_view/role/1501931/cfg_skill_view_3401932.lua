local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1701091,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID=150193105; PlayCasterBindEffect,effectID=150193106; PlayCasterMaterialAnim,animName=eff_1501931_atkult_buff_mat; PlayAudio,audioID = 2622,audioType=1; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType=4401931; PlayTargetAddBuff,buffEffectType=4101470; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; Wait,waitTime=2500; PlaySwapPetTeamOrder; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
