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
      " PlayCasterVisible, visible=1; PlayCasterBindEffect,effectID=1245; Wait,waitTime=200; PlayCasterAnimation,animName = Birth; PlayAudio,audioID = 6005,audioType=1; PlayCasterAddBuff, buffEffectType =3001; Wait,waitTime=3000; "
    }
  }
}
return config, "ID", key
