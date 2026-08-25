local SummonData = Vue.reactive({})
SummonData.deletePool = -1
SummonData.summonPoolData = {}
SummonData.gainShowList = {}
SummonData.isInit = false
SummonData.banTimes = 0
SummonData.selectCareer = DT.GetConstant("SchoolSummonInitShow")
SummonData.chooseUpMap = {}
SummonData.lastSummonType = DT.Constant.SummonRecordTypeSelectList.Data[1]
SummonData.historyDataMap = {}
SummonData.historyCountMap = {}
SummonData.discountCareer = 0
SummonData.historyCorrectNum = {}
SummonData.chooseUpSSR = {}
SummonData.limitMap = {}
SummonData.id2SummonData = {}
return SummonData
