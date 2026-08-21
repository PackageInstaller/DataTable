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
      " Jump,condition=CheckTrapSummonMonsterByResult,result=1,param=1,goto=phaseEnd; Jump,condition=CheckTrapOpenStateChangeByResult,result=0,param=1,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850; PlayCasterLegacyAnimation,animNames=eff_2801001_jiguan_transform_02; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Jump,condition=CheckTrapSummonMonsterByResult,result=1,param=1,goto=phaseEnd; Jump,condition=CheckTrapOpenStateChangeByResult,result=0,param=0,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850; PlayCasterLegacyAnimation,animNames=eff_2801001_jiguan_transform_01; "
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
      " PlayCasterBindEffect,effectID=3848 PlayCasterMaterialAnim,animName=eff_2801001_zhaohuan_skin; PlayAudio,audioID =6217,audioType=1; "
    }
  },
  {
    4,
    4,
    0,
    1,
    0,
    1000,
    {
      " PlayUIAddEscapeCount; PlayEscapeAndUpdateUI; "
    }
  }
}
return config, "ID", key
