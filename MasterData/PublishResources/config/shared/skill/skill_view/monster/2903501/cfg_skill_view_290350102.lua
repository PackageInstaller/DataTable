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
      " PlayRecoverFromGreyHP; PlayCasterAnimation,animName=skill01; Wait,waitTime=700; PlayCasterBindEffect,effectID=290350101; Wait,waitTime=1900; PlaySummonTrap,trapID=2030; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    500,
    {audioID = 6234, audioType = 1}
  }
}
return config, "ID", key
