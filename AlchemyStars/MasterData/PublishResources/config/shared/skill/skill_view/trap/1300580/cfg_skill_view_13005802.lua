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
      " PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3024,audioType=1; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=13005801; PlayCasterBindEffect,effectID =1096; PlayCasterBindEffect,effectID =1095; Wait,waitTime=1800; PlaySummonTrap,trapID=13005801; Wait,waitTime=1700; "
    }
  }
}
return config, "ID", key
