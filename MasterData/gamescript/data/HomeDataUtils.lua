local HomeData = DataCenter.homeData
local tInsert = table.insert
local tSort = table.sort
local HomeDataUtils = {}
HomeDataUtils.posMap = {
  GoldMine = {
    1,
    2,
    3
  },
  AwakerExpMine = {
    4,
    5,
    6
  },
  EnergyExpMine = {
    7,
    8,
    9
  }
}
HomeDataUtils.lTKeyMap = {
  GoldMine = "Homeland_GoldMine_",
  AwakerExpMine = "Homeland_ExpMine_",
  EnergyExpMine = "Homeland_EnergyMine_"
}
HomeDataUtils.buildingEffectMap = {
  GoldMine = "Homeland_GoldMine_Productivity",
  AwakerExpMine = "Homeland_ExpMine_Productivity",
  EnergyExpMine = "Homeland_EnergyMine_Productivity"
}
HomeDataUtils.itemIdMap = {
  GoldMine = DT.Constant[HomeDataUtils.lTKeyMap.GoldMine .. "Output_Period"].Data[1],
  AwakerExpMine = DT.Constant[HomeDataUtils.lTKeyMap.AwakerExpMine .. "Output_Period"].Data[1],
  EnergyExpMine = DT.Constant[HomeDataUtils.lTKeyMap.EnergyExpMine .. "Output_Period"].Data[1]
}
HomeDataUtils.pickUpLTMap = {
  GoldMine = "Homeland_GoldMine_Pickup_Tips",
  AwakerExpMine = "Homeland_ExpMine_Pickup_Tips",
  EnergyExpMine = "Homeland_EnergyMine_Pickup_Tips"
}

function HomeDataUtils.OpenHomeMainPanel()
  HomeDataUtils.RequestHomeData(function()
    UIManager.Instance:Reopen(Urls.ResearchPanel)
  end)
end

function HomeDataUtils.ResetRes()
  HomeData.ResBuildingUidMap = {}
end

function HomeDataUtils.InitResServerData(serverData)
  HomeDataUtils.ResetRes()
  if serverData.building then
    for _, value in pairs(serverData.building) do
      if not HomeData.ResBuildingUidMap[value.uid] then
        value.pos = HomeDataUtils.posMap[value.type][value.tid]
        value.resId = HomeDataUtils.itemIdMap[value.type]
        HomeData.ResBuildingUidMap[value.uid] = value
      end
    end
  end
end

function HomeDataUtils.UpdateResBuildingData(updateInfo)
  local uid = updateInfo.uid
  local resInfo = HomeData.ResBuildingUidMap[uid]
  if not resInfo then
    return
  else
    for key, value in pairs(updateInfo) do
      resInfo[key] = value
    end
  end
end

function HomeDataUtils.GetResBuildingDataByUid(uid)
  return HomeData.ResBuildingUidMap[uid]
end

function HomeDataUtils.GetResBuildingDataByPos(pos)
  local returnVal
  for _, value in pairs(HomeData.ResBuildingUidMap) do
    if value.pos == pos then
      returnVal = value
    end
  end
  return returnVal
end

function HomeDataUtils.GetResBuildingUidMap()
  return HomeData.ResBuildingUidMap
end

function HomeDataUtils.OpenHomeTechPanel()
  UIManager.Instance:Reopen(Urls.HomeTechPanel)
end

function HomeDataUtils.ResetTech()
  HomeData.TechBuildingTidMap = {}
end

function HomeDataUtils.InitTechServerData(serverData)
  for _, value in pairs(serverData) do
    HomeDataUtils.UpdateTechBuildingData(value)
  end
  for _, value in pairs(HomeData.TechBuildingTidMap) do
    value.showState = HomeDataUtils.GetShowState(value)
  end
  HomeDataUtils.UpdateTechBuildingState()
end

function HomeDataUtils.UpdateTechBuildingData(updateInfo)
  local tid = updateInfo.tid
  local techInfo = HomeData.TechBuildingTidMap[tid]
  if not techInfo then
    return
  end
  for key, value in pairs(updateInfo) do
    techInfo[key] = value
  end
end

function HomeDataUtils.UpdateTechBuildingState()
  HomeData.TechBuildingState = CommonDefine.TechBuildingState.TechIdle
  for _, value in pairs(HomeData.TechBuildingTidMap) do
    if value.state == CommonDefine.CommonState.Running then
      HomeData.TechBuildingState = CommonDefine.TechBuildingState.TechDoing
      break
    elseif value.state == CommonDefine.CommonState.Confirm then
      HomeData.TechBuildingState = CommonDefine.TechBuildingState.TechReceive
      break
    end
  end
end

function HomeDataUtils.UnLockPostTech(inputTid)
end

function HomeDataUtils.GetTechNodeList()
  local tempList = {}
  local returnList = {}
  for _, value in pairs(tempList) do
    tInsert(returnList, value)
  end
  tSort(returnList, function(a, b)
    return a.level < b.level
  end)
  return returnList
end

function HomeDataUtils.GetFinishTEList(effectType)
  return HomeData.TechFinishEffectList[effectType]
end

function HomeDataUtils.GetTechEffectName(techType, var1, var2)
  local returnStr = ""
  return returnStr
end

function HomeDataUtils.InitFinishTEList()
  HomeData.TechFinishEffectList = {
    [CommonDefine.TechEffect.PromoteGoldMineLevel] = {},
    [CommonDefine.TechEffect.PromoteAwakerExpMineLevel] = {},
    [CommonDefine.TechEffect.PromoteEnergyMineLevel] = {},
    [CommonDefine.TechEffect.PromoteAppiontTeamNum] = {},
    [CommonDefine.TechEffect.PromoteTrinketMaxLevel] = {},
    [CommonDefine.TechEffect.TrinketSuitsNeedNum] = {},
    [CommonDefine.TechEffect.PromoteAwakerSchoolMaxLevel] = {},
    [CommonDefine.TechEffect.PromoteAwakerTypeMaxLevel] = {},
    [CommonDefine.TechEffect.UnlockCopy] = {},
    [CommonDefine.TechEffect.UnlockShopGoods] = {},
    [CommonDefine.TechEffect.PromoteDailyAppiontTimes] = {},
    [CommonDefine.TechEffect.UnlockTrinketRecast] = {},
    [CommonDefine.TechEffect.PromoteAppiontLevel] = {}
  }
end

function HomeDataUtils.GetTechBuildingState()
  return HomeData.TechBuildingState
end

function HomeDataUtils.GetResearchingItem()
  for _, value in pairs(HomeData.TechBuildingTidMap) do
    if value.state == CommonDefine.CommonState.Running then
      HomeData.ResearchingItem = value
      break
    end
  end
  return HomeData.ResearchingItem
end

function HomeDataUtils.GetCompletedItem()
  for _, value in pairs(HomeData.TechBuildingTidMap) do
    if value.state == CommonDefine.CommonState.Confirm then
      HomeData.CompletedItem = value
      break
    end
  end
  return HomeData.CompletedItem
end

function HomeDataUtils.GetTechItemDataByTid(tid)
  return HomeData.TechBuildingTidMap[tid]
end

function HomeDataUtils.GetCurShowLevel(compareLevel)
  local returnLevel = 100
  return returnLevel
end

function HomeDataUtils.GetShowState(techItemData)
  local returnState
  local serverState = techItemData.state
  if not serverState then
    returnState = CommonDefine.TechItemState.NotUnLock
  elseif serverState == CommonDefine.CommonState.Realy then
    local preTechItem
    if not preTechItem or preTechItem.state == CommonDefine.CommonState.Finish then
      returnState = CommonDefine.TechItemState.UnLockCanResearch
    else
      returnState = CommonDefine.TechItemState.UnLockNotResearch
    end
  elseif serverState == CommonDefine.CommonState.Running then
    returnState = CommonDefine.TechItemState.Doing
  elseif serverState == CommonDefine.CommonState.Confirm then
    returnState = CommonDefine.TechItemState.Receive
  elseif serverState == CommonDefine.CommonState.Finish then
    returnState = CommonDefine.TechItemState.Done
  end
  return returnState
end

function HomeDataUtils.RequestHomeData(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeOpen", function(data)
    HomeDataUtils.InitResServerData(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求家园数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function HomeDataUtils.RequestTechData(callback)
  HomeDataUtils.InitFinishTEList()
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeOpenTechnology", function(data)
    HomeDataUtils.InitTechServerData(data)
    if callback then
      callback()
    end
  end, function(_)
  end)
end

function HomeDataUtils.GainResBuildPrize(uid)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeGainBuildPrize", function(data)
    HomeDataUtils.UpdateResBuildingData(data)
  end, function(data)
    Logger.Info("========== 请求研究所数据失败 ==========\n", table.tostring(data or {}))
  end, uid)
end

function HomeDataUtils.StudyTechnology(tid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeStudyTechnology", function(data)
    if callback then
      callback()
    end
    data.showState = HomeDataUtils.GetShowState(data)
    HomeDataUtils.UpdateTechBuildingData(data)
    HomeDataUtils.UpdateTechBuildingState()
    HomeDataUtils.UnLockPostTech(data.tid)
  end, function(data)
    Logger.Info("========== 请求开始研究失败 ==========\n", table.tostring(data or {}))
  end, tid)
end

function HomeDataUtils.CancelStudyTechnology(tid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeCancelStudyTechnology", function(data)
    if callback then
      callback()
    end
    data.showState = HomeDataUtils.GetShowState(data)
    HomeDataUtils.UpdateTechBuildingData(data)
    HomeDataUtils.UpdateTechBuildingState()
  end, function(data)
    Logger.Info("========== 请求取消研究失败 ==========\n", table.tostring(data or {}))
  end, tid)
end

function HomeDataUtils.QuickenTechnology(tid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeQuickenTechnology", function(data)
    if callback then
      callback()
    end
    local updateInfo = {
      tid = data.tid,
      state = data.state,
      showState = HomeDataUtils.GetShowState(data)
    }
    HomeDataUtils.UpdateTechBuildingData(updateInfo)
    HomeDataUtils.UpdateTechBuildingState()
    HomeDataUtils.UnLockPostTech(data.tid)
  end, function(data)
    Logger.Info("========== 请求加速研究失败 ==========\n", table.tostring(data or {}))
  end, tid)
end

function HomeDataUtils.StudyTechnologyFinish(tid, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHomeStudyTechnologyFinish", function(data)
    if callback then
      callback()
    end
    data.showState = HomeDataUtils.GetShowState(data)
    HomeDataUtils.UpdateTechBuildingData(data)
    HomeDataUtils.UpdateTechBuildingState()
    HomeDataUtils.UnLockPostTech(data.tid)
  end, function(data)
    Logger.Info("========== 请求完成研究失败 ==========\n", table.tostring(data or {}))
  end, tid)
end

function HomeDataUtils.IsInArray(val, array)
  for _, value in pairs(array) do
    if value == val then
      return true
    end
  end
  return false
end

return HomeDataUtils
