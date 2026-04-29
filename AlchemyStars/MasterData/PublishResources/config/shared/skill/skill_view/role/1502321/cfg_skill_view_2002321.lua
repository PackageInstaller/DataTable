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
      "PlayAudio,audioID =150232102,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID =150232107; PlayCasterBindEffect,effectID =150232108; PlayCasterSubMaterialAnim,nodeName=1502321_weapon,animName=eff_1502321_atkchain_weapon; Wait,waitTime = 3000; "
    }
  },
  {
    2,
    2,
    7,
    1,
    1,
    1250,
    {
      gridEffectID = 0,
      columnInternalTime = 0,
      hitAnimName = "Hit",
      hitEffectID = 0,
      gridEffectWaitTime = 0,
      hitWaitTime = 0
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1250,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=20031; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
