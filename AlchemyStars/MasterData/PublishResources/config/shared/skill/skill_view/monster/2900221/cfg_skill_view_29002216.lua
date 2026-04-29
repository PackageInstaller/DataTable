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
      effectIDList = {
        960,
        962,
        963,
        965,
        966
      }
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
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
    3,
    0,
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
    500,
    {
      effectIDList = {819, 823}
    }
  },
  {
    6,
    6,
    0,
    1,
    5,
    500,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterBindEffect,effectID=963; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=964,turnToTarget=1,deathClear=0,label=doAgain; PlayTargetAddBuff,buffID=30061; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    7,
    7,
    0,
    1,
    6,
    1000,
    {
      " PlayChangeElement; PlayCasterBindEffect,effectID=956; PlayCasterBindEffect,effectID=957; PlayCasterBindEffect,effectID=958; Wait,waitTime=1000; "
    }
  },
  {
    8,
    8,
    0,
    1,
    7,
    0,
    {
      " PlayCasterAddBuff,buffID=30181,remove=1; PlayCasterAddBuff,buffID=30186,remove=1; "
    }
  }
}
return config, "ID", key
