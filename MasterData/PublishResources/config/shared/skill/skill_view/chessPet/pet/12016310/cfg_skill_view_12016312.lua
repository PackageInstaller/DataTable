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
      " PlayGridDark,darkType=0; PlayCasterAnimation,animName=Skill02; PlayCasterMeshVisible,visible=0,objs=1201631_weapon; PlayCasterBindEffect,effectID =3466; PlayCasterBindEffect,effectID =3469; PlayCasterBindEffect,effectID =3470; PlayAudio,audioID = 2434; Wait,waitTime=6000; PlayGridDark,darkType=1; "
    },
    {"", "1,-1"}
  },
  {
    2,
    2,
    45,
    1,
    0,
    0,
    {
      prob = 30,
      tipsList = {12016312}
    }
  }
}
return config, "ID", key
