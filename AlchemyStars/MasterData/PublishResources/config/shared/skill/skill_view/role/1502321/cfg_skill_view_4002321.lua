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
      "DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=8002321; PlaySummonTrap,trapID=8002322; PlaySummonTrap,trapID=8002323; PlaySummonTrap,trapID=8002324; PlaySummonTrap,trapID=8002325; PlaySummonTrap,trapID=8002326; PlaySummonTrap,trapID=8052321; PlaySummonTrap,trapID=8052322; PlaySummonTrap,trapID=8052323; PlaySummonTrap,trapID=8052324; PlaySummonTrap,trapID=8052325; PlaySummonTrap,trapID=8052326; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=4002323,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;"
    }
  }
}
return config, "ID", key
