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
      " PlayCasterBindEffect, effectID=2777; Wait,waitTime=700; DataTakeSceneScreenshot; PlaySchummerBattleFailed,effectID=2778; PlayAudio,audioID = 6082,audioType=1; Wait,waitTime=4000; "
    }
  }
}
return config, "ID", key
