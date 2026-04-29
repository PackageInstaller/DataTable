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
      " PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 7000,audioType=1; Wait,waitTime=1500; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=8; DataSelectScopeGridRangeIndex,index=1; DataSelectBuff,buffIndex=1; PlayGridRangeEffect,effectID=1132,step=4,offset=0.5|0.5,label=playRangeEffect; Wait,waitTime=100; PlayAudio,audioID = 7001,audioType=1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayTargetAddBuff,buffEffectType=501006; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
