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
      " PlayCasterAnimation,animName = AtkChain2; PlayCasterBindEffect,effectID =1716; PlayAudio,audioID = 3051,audioType=1; Wait,waitTime=1600; PlayAddHpText; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
