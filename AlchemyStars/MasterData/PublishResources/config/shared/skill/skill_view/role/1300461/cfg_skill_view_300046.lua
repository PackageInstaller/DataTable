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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1300461,waitTime = 2000;"
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
      " DataSelectPickupGrid,gridIndex=1; PlayTurnToPickUpDirection; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2094,audioType=1; PlayCasterBindEffect,effectID =733; PlayCasterBindEffect,effectID =735; Wait,waitTime=2000; PlayFlyEffectCasterToTarget,flyEffectID = 736,flySpeed = 100,flyTrace = 2,pickUpPosAsTarget=1; PlaySelectCenterGridEffect,effectID =734,intervalTime=0; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    1000,
    {
      "DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10042,label=addbuff; PlayTargetAddBuff,buffID=30061; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=addbuff; "
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " PlayMultiTraction,moveSpeed=3,label=Traction; Wait,waitTime=5000; "
    }
  }
}
return config, "ID", key
