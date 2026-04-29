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
      " PlayCasterAnimation,animName=skill01; PlayCasterBindEffect,effectID =290510101; PlaySummonTrap,trapID=2905111; PlaySummonTrap,trapID=2905112; PlayDeleteCasterEffect,effectIDList=290510102; PlayAudio,audioID=6277,audioType=1; Wait,waitTime=200; "
    }
  }
}
return config, "ID", key
