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
        952,
        953,
        956,
        957,
        958
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
      " PlayCasterAnimation,animName = Skill03L; PlayCasterBindEffect,effectID=955; Wait,waitTime=1800; PlayAudio,audioID = 6051,audioType=1; "
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
      effectIDList = {817, 821}
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
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=2; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=967,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,bodyArea=4; PlayTargetAddBuff,buffID=20011; Wait,waitTime=200; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    7,
    7,
    0,
    1,
    6,
    0,
    {
      " PlayChangeElement; PlayCasterBindEffect,effectID=966; Wait,waitTime=1000; "
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
