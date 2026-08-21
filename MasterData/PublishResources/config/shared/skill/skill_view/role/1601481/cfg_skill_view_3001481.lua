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
      " PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 2439,audioType=1; PlayCasterBindEffect,effectID=3502; PlaySummonTrap,trapID=16014811; PlaySummonTrap,trapID=16014812; PlaySummonTrap,trapID=16014813; PlayMoveTrap; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffEffectType=420148; Wait,waitTime=1800; "
    }
  }
}
return config, "ID", key
