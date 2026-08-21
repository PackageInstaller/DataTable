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
      " PlayCasterAnimation,animName =Skill02_copy; PlayAudio,audioID = 5026,audioType=1; PlayCasterBindEffect,effectID=655; PlayMakePhantom,flyDuration=1000,eftID=657,eftPosYa=2.4,eftPosYb=0.7; "
    }
  }
}
return config, "ID", key
