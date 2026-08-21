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
      " PlayCloseMonsterPreviewRange; "
    }
  },
  {
    2,
    2,
    38,
    1,
    0,
    0,
    {
      effectIDList = {953}
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " PlayCasterAnimation,animName = Skill03L; PlayCasterBindEffect,effectID=955; PlayAudio,audioID = 6051,audioType=1; "
    }
  },
  {
    4,
    4,
    0,
    1,
    0,
    0,
    {
      " PlayAbsorbPieceEffect,flyEffectID=817,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=1,targetPos=Hit,waitFlyEffectTime=500; PlayCasterAddBuff,buffID=40043; "
    }
  },
  {
    5,
    5,
    38,
    2,
    4,
    500,
    {
      effectIDList = {
        817,
        821,
        952
      }
    }
  }
}
return config, "ID", key
