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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,petID=1200501,waitTime = 2000; "
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
      " PlayGridDark,darkType=0; PlayCasterAnimation,animName = AtkUlt03; PlayCasterMeshVisible,visible=0,objs=1201631_weapon; PlayCasterBindEffect,effectID =3467; PlayCasterBindEffect,effectID =3469; PlayCasterBindEffect,effectID =3470; PlayAudio,audioID = 2435; Wait,waitTime=10000; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=420163,label=doAgain; PlayTargetAddBuff,buffEffectType =420163; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; PlayGridDark,darkType=1; "
    },
    {"", "1,-1"}
  }
}
return config, "ID", key
