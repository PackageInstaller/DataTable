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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601551,waitTime = 2000;"
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
      " PlayCasterBindEffect,effectID =3644; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2470,audioType=1; Wait,waitTime=400; PlayCasterBindEffect,effectID =3645; Wait,waitTime=1650; PlayCameraEffect, effectID=3643; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait; PlayTargetAddBuff,buffEffectType =4300155,label=checkbuff; PlayTargetAddBuff,buffEffectType =160155301; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; "
    }
  }
}
return config, "ID", key
