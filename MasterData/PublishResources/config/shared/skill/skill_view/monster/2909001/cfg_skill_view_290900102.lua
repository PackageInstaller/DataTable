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
      " PlayAudio,audioID=290900102,audioType=1; PlayCasterAnimation,animName=Skill02; PlayCameraEffect,effectID = 290900105; PlayCasterBindEffect,effectID=290900103; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " PlaySeaWaveAttack,effectID=290900104,effectBind=hitpoint,hitAnimaName=Hit,hitEffectID=290900106,hitBackEndEffectID=290900107,hitBackSpeed=12,boardCenterPos=5|5,hitBackEndTime=300; "
    }
  }
}
return config, "ID", key
