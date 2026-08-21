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
    1,
    0,
    {
      effectIDList = {962}
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
      " PlayCasterAnimation,animName = Skill03R; PlayAudio,audioID = 6053,audioType=1; PlayCasterBindEffect,effectID=965; PlayAudio,audioID = 5038,audioType=1; "
    }
  },
  {
    4,
    4,
    0,
    1,
    0,
    500,
    {
      " PlayAbsorbPieceEffect,flyEffectID=819,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=1,targetPos=Hit,waitFlyEffectTime=500; "
    }
  },
  {
    5,
    5,
    38,
    1,
    4,
    1000,
    {
      effectIDList = {
        819,
        823,
        965
      }
    }
  }
}
return config, "ID", key
