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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400161,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayCasterInTrapPos,trapID=17023611; PlayAudio,audioID = 170236104,audioType=1; PlayCasterAnimation,animName = AtkUlt3; PlayCasterMaterialAnim,animName=eff_1702361_atkult2_main; PlayCasterBindEffect,effectID =17023621; Wait,waitTime=500; PlayCasterBindEffect,effectID =17023619; Wait,waitTime=2500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    594,
    {
      "PlayFromSPTrapMoveToCaster,trapID=17023611,time=100;"
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    700,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=17023620,randomRotateXYZ=180,offsetHigh=0.1,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    700,
    {
      " DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
