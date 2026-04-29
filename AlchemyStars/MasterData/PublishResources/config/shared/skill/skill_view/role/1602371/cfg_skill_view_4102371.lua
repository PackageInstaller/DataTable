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
      " PlayAudio,audioID =160237106,audioType=1; DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=8002371; PlaySummonTrap,trapID=8002372; PlaySummonTrap,trapID=8002373; PlaySummonTrap,trapID=8002374; PlaySummonTrap,trapID=8062371; PlaySummonTrap,trapID=8062372; PlaySummonTrap,trapID=8062373; PlaySummonTrap,trapID=8062374; PlaySummonTrap,trapID=8402375; PlaySummonTrap,trapID=8462375; PlaySummonTrap,trapID=8502375; PlaySummonTrap,trapID=8562375; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4002371,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;"
    }
  }
}
return config, "ID", key
