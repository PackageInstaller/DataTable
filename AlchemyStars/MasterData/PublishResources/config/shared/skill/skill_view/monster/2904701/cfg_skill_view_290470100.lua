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
      " PlayCasterAnimation,animName=Birth; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterBindEffect,effectID=290470100; PlayAudio,audioID=6266,audioType=1; Wait,waitTime=1600; PlaySummonTrapBySummonEveryThing,trapID=2904701; "
    }
  }
}
return config, "ID", key
