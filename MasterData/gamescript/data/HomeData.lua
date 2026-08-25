local HomeData = Vue.reactive({})
HomeData.ResBuildingUidMap = {}
HomeData.TechBuildingTidMap = {}
HomeData.ResearchingItem = nil
HomeData.CompletedItem = nil
HomeData.TechBuildingState = CommonDefine.TechBuildingState.TechIdle
HomeData.TechFinishEffectList = {}
return HomeData
