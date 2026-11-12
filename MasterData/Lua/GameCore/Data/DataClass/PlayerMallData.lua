local PlayerMallData = class("PlayerMallData")
local TimerManager = require("GameCore.Timer.TimerManager")
local MessageBoxManager = require("GameCore.Module.MessageBoxManager")
local LocalData = require("GameCore.Data.LocalData")
local ModuleManager = require("GameCore.Module.ModuleManager")
local ClientManager = CS.ClientManager.Instance
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local SDKManager = CS.SDKManager.Instance
local DisplayMode = {
  Hide = 0,
  End = 1,
  Stay = 2
}
local OrderStatus = {
  Unpaid = "Unpaid",
  Done = "Done",
  Retry = "Retry",
  Error = "Error"
}

function PlayerMallData:Init()
  self._tbNextMallPackage = nil
  self._tbNextMallShop = nil
  self._tbOrderCollect = {}
  self._mapOrderId = {}
  self._nOrderIdPaying = nil
  self._tbWaitingOrderCollect = nil
  self._mapOrderReward = nil
  self._mapOrderCollecting = nil
  self._bWaitTimeOut = false
  self._bRetry = false
  self._bProcessingOrder = false
  self._timerOrderCollect = nil
  self._timerOrderWait = nil
  self._tbPackagePage = {}
  self._tbExchangeShop = {}
  self._tbPackage = {}
  self._mapActivityProduct = {}
  self._mapActivityCfgByActId = {}
  self._sActivityNewId = nil
  EventManager.Add("OnSdkPaySuc", PlayerMallData, self.OnEvent_PayRespone)
  EventManager.Add("OnSdkPayFail", PlayerMallData, self.OnEvent_PayRespone)
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  self:ProcessExchangeShop()
  self:ProcessPackagePage()
  self:ProcessMallActivityCfg()
end

function PlayerMallData:UnInit()
  self._tbNextMallPackage = nil
  self._tbNextMallShop = nil
  self._tbOrderCollect = nil
  self._mapOrderId = nil
  self._nOrderIdPaying = nil
  self._tbWaitingOrderCollect = nil
  self._mapOrderReward = nil
  self._mapOrderCollecting = nil
  self._bWaitTimeOut = false
  self._bRetry = false
  self._bProcessingOrder = false
  self._timerOrderCollect = nil
  self._timerOrderWait = nil
  self._tbPackagePage = nil
  self._tbExchangeShop = nil
  self._tbPackage = nil
  self._mapActivityProduct = nil
  self._mapActivityCfgByActId = nil
  self._sActivityNewId = nil
  EventManager.Remove("OnSdkPaySuc", PlayerMallData, self.OnEvent_PayRespone)
  EventManager.Remove("OnSdkPayFail", PlayerMallData, self.OnEvent_PayRespone)
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerMallData:GetExchangeShop()
  return self._tbExchangeShop
end

function PlayerMallData:GetPackagePage(nType)
  return self._tbPackagePage[nType] or {}
end

function PlayerMallData:GetGroupSubType(nGroupId)
  local groupCfg = ConfigTable.GetData("MallPackagePage", nGroupId)
  if groupCfg == nil then
    return nil
  end
  return groupCfg.SubType
end

function PlayerMallData:IsFurnitureGroup(nGroupId)
  return self:GetGroupSubType(nGroupId) == GameEnum.MallItemSubType.Furniture
end

function PlayerMallData:IsFurnitureValueGroup(nGroupId)
  local nSubType = self:GetGroupSubType(nGroupId)
  return nSubType == GameEnum.MallItemSubType.Furniture or nSubType == GameEnum.MallItemSubType.FurnitureSet
end

function PlayerMallData:GetPackageSubType(sId)
  local mapCfg = ConfigTable.GetData("MallPackage", sId)
  if mapCfg == nil then
    return nil
  end
  return self:GetGroupSubType(mapCfg.GroupId)
end

function PlayerMallData:GetPackageCollectionValue(mapCfg)
  if mapCfg == nil or mapCfg.Items == nil then
    return 0
  end
  local nValue = 0
  for sItemId in pairs(decodeJson(mapCfg.Items) or {}) do
    local furnitureCfg = ConfigTable.GetData("DormFurniture", tonumber(sItemId))
    if furnitureCfg ~= nil then
      nValue = nValue + furnitureCfg.CollectionValue
    end
  end
  return nValue
end

function PlayerMallData:GetFurnitureSetCollectionValue(mapCfg)
  if mapCfg == nil or mapCfg.Items == nil then
    return 0
  end
  if self:GetGroupSubType(mapCfg.GroupId) ~= GameEnum.MallItemSubType.FurnitureSet then
    return 0
  end
  local nValue = 0
  for sSetId in pairs(decodeJson(mapCfg.Items) or {}) do
    local itemCfg = ConfigTable.GetData_Item(tonumber(sSetId))
    if itemCfg ~= nil then
      for sItemId in pairs(decodeJson(itemCfg.UseArgs) or {}) do
        local furnitureCfg = ConfigTable.GetData("DormFurniture", tonumber(sItemId))
        if furnitureCfg ~= nil then
          nValue = nValue + furnitureCfg.CollectionValue
        end
      end
    end
  end
  return nValue
end

function PlayerMallData:GetFurnitureValue(mapCfg)
  if mapCfg == nil then
    return 0
  end
  if self:GetGroupSubType(mapCfg.GroupId) == GameEnum.MallItemSubType.FurnitureSet then
    return self:GetFurnitureSetCollectionValue(mapCfg)
  end
  return self:GetPackageCollectionValue(mapCfg)
end

function PlayerMallData:CheckOrderProcess()
  return self._bProcessingOrder
end

function PlayerMallData:BuyGem(sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.Mall
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendMallGemOrderReq(sId, callback)
end

function PlayerMallData:BuyPackage(sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.Mall
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendMallPackageOrderReq(sId, callback)
end

function PlayerMallData:BuyReengagementPackage(sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.Mall
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendMallReengagementPackageOrderReq(sId, callback)
end

function PlayerMallData:BuyMonthlyCard(sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.Mall
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendMallMonthlyCardOrderReq(sId, callback)
end

function PlayerMallData:BuyWeeklyCard(sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.Mall
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendWeeklyCardOrderReq(sId, callback)
end

function PlayerMallData:BuyMallActivity(sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.Mall
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendMallActivityOrderReq(sId, callback)
end

function PlayerMallData:BuyBattlePass(nMode, nVersion, sId, sStatistical)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("purchase_click", tab)
  
  local function callback(mapData)
    self._mapOrderId[mapData.ExtraData] = {
      nOrderId = mapData.Id,
      StatisticalGroup = sStatistical,
      nType = AllEnum.RMBOrderType.BattlePass
    }
    EventManager.Hit(EventId.BlockInput, true)
    self._nOrderIdPaying = mapData.Id
    SDKManager:Pay(sId, mapData.NotifyUrl, mapData.ExtraData)
  end
  
  self:SendBattlePassOrderReq(nMode, nVersion, callback)
end

function PlayerMallData:ProcessExchangeShop()
  self._tbExchangeShop = {}
  
  local function func_ForEach_ExchangeShop(mapData)
    table.insert(self._tbExchangeShop, mapData)
  end
  
  ForEachTableLine(DataTable.MallShopPage, func_ForEach_ExchangeShop)
  table.sort(self._tbExchangeShop, function(a, b)
    return a.Sort < b.Sort
  end)
end

function PlayerMallData:ParseShopList(tbList)
  local tbShop = {}
  for _, v in pairs(tbList) do
    local mapCfg = ConfigTable.GetData("MallShop", v.Id)
    if mapCfg then
      local mapPage = ConfigTable.GetData("MallShopPage", mapCfg.GroupId)
      if mapPage and (v.Stock > 0 or mapCfg.DisplayMode ~= DisplayMode.Hide) then
        local nDeListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfg.DeListTime)
        local nNextRefreshTime, bPrioritizeDeList = self:CalNextTime(v.RefreshTime, nDeListTime)
        local mapPackage = {
          sId = v.Id,
          nCurStock = v.Stock,
          nPageSort = mapPage.Sort,
          nSort = mapCfg.Sort,
          nDisplayMode = mapCfg.DisplayMode,
          bPrioritizeDeList = bPrioritizeDeList,
          nNextRefreshTime = nNextRefreshTime
        }
        table.insert(tbShop, mapPackage)
      end
    end
  end
  
  local function comp(a, b)
    if (a.nCurStock == 0 and a.nDisplayMode == DisplayMode.End) ~= (b.nCurStock == 0 and b.nDisplayMode == DisplayMode.End) then
      return (a.nCurStock ~= 0 or a.nDisplayMode ~= DisplayMode.End) and b.nCurStock == 0 and b.nDisplayMode == DisplayMode.End
    elseif a.nPageSort ~= b.nPageSort then
      return a.nPageSort < b.nPageSort
    else
      return a.nSort < b.nSort
    end
  end
  
  table.sort(tbShop, comp)
  return tbShop
end

function PlayerMallData:CalShopAutoTime(tbList)
  local tbTime = {}
  for _, mapData in pairs(tbList) do
    if mapData.nNextRefreshTime > 0 then
      table.insert(tbTime, mapData.nNextRefreshTime)
    end
  end
  for _, mapData in pairs(self._tbNextMallShop or {}) do
    table.insert(tbTime, mapData.nListTime)
  end
  if #tbTime == 0 then
    return 0
  end
  table.sort(tbTime)
  return tbTime[1] - ClientManager.serverTimeStamp
end

function PlayerMallData:UpdateNextMallShop()
  local nServerTimeStamp = ClientManager.serverTimeStamp
  if self._tbNextMallShop == nil then
    self._tbNextMallShop = {}
    
    local function func_ForEach_Shop(mapCfgData)
      local nListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfgData.ListTime)
      if 0 < nListTime and nListTime > nServerTimeStamp then
        table.insert(self._tbNextMallShop, {
          nId = mapCfgData.Id,
          nListTime = nListTime
        })
      end
    end
    
    ForEachTableLine(DataTable.MallShop, func_ForEach_Shop)
  else
    local nCount = #self._tbNextMallShop
    if 0 < nCount then
      for i = nCount, -1 do
        if nServerTimeStamp >= self._tbNextMallShop[i].nListTime then
          table.remove(self._tbNextMallShop, i)
        end
      end
    end
  end
end

function PlayerMallData:ProcessPackagePage()
  self._tbPackagePage = {}
  
  local function func_ForEach_PackagePage(mapData)
    local nType = mapData.Type
    if self._tbPackagePage[nType] == nil then
      self._tbPackagePage[nType] = {}
    end
    table.insert(self._tbPackagePage[nType], mapData)
  end
  
  ForEachTableLine(DataTable.MallPackagePage, func_ForEach_PackagePage)
  for _, v in pairs(self._tbPackagePage) do
    table.sort(v, function(a, b)
      return a.Sort < b.Sort
    end)
  end
end

function PlayerMallData:ParsePackageList(tbList)
  local tbPackage = {}
  for _, v in pairs(tbList) do
    local mapCfg = ConfigTable.GetData("MallPackage", v.Id)
    if mapCfg then
      local mapPage = ConfigTable.GetData("MallPackagePage", mapCfg.GroupId)
      if mapPage and (v.Stock > 0 or mapCfg.DisplayMode ~= DisplayMode.Hide) then
        local nDeListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfg.DeListTime)
        local nNextRefreshTime, bPrioritizeDeList = self:CalNextTime(v.RefreshTime, nDeListTime)
        local mapPackage = {
          sId = v.Id,
          nCurStock = v.Stock,
          nPageSort = mapPage.Sort,
          nSort = mapCfg.Sort,
          nDisplayMode = mapCfg.DisplayMode,
          bPrioritizeDeList = bPrioritizeDeList,
          nNextRefreshTime = nNextRefreshTime
        }
        table.insert(tbPackage, mapPackage)
      end
    end
  end
  
  local function comp(a, b)
    if (a.nCurStock == 0 and a.nDisplayMode == DisplayMode.End) ~= (b.nCurStock == 0 and b.nDisplayMode == DisplayMode.End) then
      return (a.nCurStock ~= 0 or a.nDisplayMode ~= DisplayMode.End) and b.nCurStock == 0 and b.nDisplayMode == DisplayMode.End
    elseif a.nPageSort ~= b.nPageSort then
      return a.nPageSort < b.nPageSort
    else
      return a.nSort < b.nSort
    end
  end
  
  table.sort(tbPackage, comp)
  return tbPackage
end

function PlayerMallData:CalNextTime(nReTime, nDeTime)
  if 0 < nDeTime then
    if 0 < nReTime then
      if nDeTime < nReTime then
        return nDeTime, true
      else
        return nReTime, false
      end
    else
      return nDeTime, true
    end
  else
    return nReTime, false
  end
end

function PlayerMallData:CalPackageAutoTime(tbPackageList)
  local tbTime = {}
  for _, mapData in pairs(tbPackageList) do
    if mapData.nNextRefreshTime > 0 then
      table.insert(tbTime, mapData.nNextRefreshTime)
    end
  end
  for _, mapData in pairs(self._tbNextMallPackage) do
    table.insert(tbTime, mapData.nListTime)
  end
  if #tbTime == 0 then
    return 0
  end
  table.sort(tbTime)
  return tbTime[1] - ClientManager.serverTimeStamp
end

function PlayerMallData:GetMallPackageData(sId)
  for _, mapData in pairs(self._tbPackage) do
    if mapData.sId == sId then
      return mapData
    end
  end
  return nil
end

function PlayerMallData:UpdateNextMallPackage()
  local nServerTimeStamp = ClientManager.serverTimeStamp
  if self._tbNextMallPackage == nil then
    self._tbNextMallPackage = {}
    
    local function func_ForEach_Package(mapCfgData)
      local nListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfgData.ListTime)
      if 0 < nListTime and nListTime > nServerTimeStamp then
        table.insert(self._tbNextMallPackage, {
          nId = mapCfgData.Id,
          nListTime = nListTime
        })
      end
    end
    
    ForEachTableLine(DataTable.MallPackage, func_ForEach_Package)
  else
    local nCount = #self._tbNextMallPackage
    if 0 < nCount then
      for i = nCount, -1 do
        if nServerTimeStamp >= self._tbNextMallPackage[i].nListTime then
          table.remove(self._tbNextMallPackage, i)
        end
      end
    end
  end
end

function PlayerMallData:GetPackageToggle(nTag)
  if nTag == nil then
    return nil
  elseif nTag == GameEnum.MallItemType.Package then
    return AllEnum.MallToggle.Package
  elseif nTag == GameEnum.MallItemType.Skin then
    return AllEnum.MallToggle.Skin
  elseif nTag == GameEnum.MallItemType.Furniture then
    return AllEnum.MallToggle.Furniture
  end
  return nil
end

function PlayerMallData:ProcessMallActivityCfg()
  self._mapActivityCfgByActId = {}
  
  local function func_ForEach_MallActivity(mapData)
    local nActId = mapData.ActivityId
    if nActId == nil or nActId == 0 then
      return
    end
    local mapCur = self._mapActivityCfgByActId[nActId]
    if mapCur == nil or tostring(mapData.Id) < tostring(mapCur.Id) then
      self._mapActivityCfgByActId[nActId] = mapData
    end
  end
  
  ForEachTableLine(DataTable.MallActivity, func_ForEach_MallActivity)
end

function PlayerMallData:GetMallActivityCfgByActId(nActId)
  return self._mapActivityCfgByActId[nActId]
end

function PlayerMallData:GetMallActivityProduct(sId)
  return self._mapActivityProduct[sId]
end

function PlayerMallData:CheckMallActivityPurchased(sId)
  local mapInfo = self._mapActivityProduct[sId]
  return mapInfo ~= nil and mapInfo.Purchased == true
end

function PlayerMallData:GetCurMallActivityCfg()
  local actData = PlayerData.Activity:GetMallActivityData()
  if actData == nil then
    return nil
  end
  return self:GetMallActivityCfgByActId(actData:GetActId())
end

function PlayerMallData:CheckMallActivityRedDot(actData)
  actData = actData or PlayerData.Activity:GetMallActivityData()
  return actData ~= nil and actData.CheckMallRedDot ~= nil and actData:CheckMallRedDot() == true
end

function PlayerMallData:UpdateMallActivityFuncRedDot(actData)
  RedDotManager.SetValid(RedDotDefine.Mall_Activity_RedDot, {
    AllEnum.MallToggle.Activity
  }, self:CheckMallActivityRedDot(actData))
end

function PlayerMallData:CheckMallActivityNewRead(sId)
  local sCheckNew = LocalData.GetPlayerLocalData("Mall_Activity_New") or ""
  local tbCheckNew = string.split(sCheckNew, ",")
  return table.indexof(tbCheckNew, tostring(sId)) ~= 0
end

function PlayerMallData:UpdateMallActivityRedDot()
  local actData = PlayerData.Activity:GetMallActivityData()
  self:UpdateMallActivityFuncRedDot(actData)
  local mapCfg = actData ~= nil and self:GetMallActivityCfgByActId(actData:GetActId()) or nil
  local sId = mapCfg ~= nil and tostring(mapCfg.Id) or nil
  if self._sActivityNewId ~= nil and self._sActivityNewId ~= sId then
    RedDotManager.SetValid(RedDotDefine.Mall_Activity_New, {
      AllEnum.MallToggle.Activity,
      self._sActivityNewId
    }, false)
    self._sActivityNewId = nil
  end
  if mapCfg == nil then
    EventManager.Hit("Mall_Refresh_Reddot")
    return
  end
  local bNew = mapCfg.IsNew == true and not self:CheckMallActivityNewRead(sId)
  RedDotManager.SetValid(RedDotDefine.Mall_Activity_New, {
    AllEnum.MallToggle.Activity,
    sId
  }, bNew)
  self._sActivityNewId = bNew and sId or nil
  EventManager.Hit("Mall_Refresh_Reddot")
end

function PlayerMallData:RemoveMallActivityNew()
  local mapCfg = self:GetCurMallActivityCfg()
  if mapCfg == nil then
    return
  end
  local sId = tostring(mapCfg.Id)
  RedDotManager.SetValid(RedDotDefine.Mall_Activity_New, {
    AllEnum.MallToggle.Activity,
    sId
  }, false)
  self._sActivityNewId = nil
  local sCheckNew = LocalData.GetPlayerLocalData("Mall_Activity_New") or ""
  local tbCheckNew = string.split(sCheckNew, ",")
  if table.indexof(tbCheckNew, sId) == 0 then
    LocalData.SetPlayerLocalData("Mall_Activity_New", sCheckNew .. "," .. sId)
  end
  EventManager.Hit("Mall_Refresh_Reddot")
end

function PlayerMallData:CacheDailyMallReward(bDailyReward)
  self.bDailyReward = bDailyReward
  RedDotManager.SetValid(RedDotDefine.Mall_Daily, nil, self.bDailyReward)
end

function PlayerMallData:GetDailyMallReward()
  return self.bDailyReward
end

function PlayerMallData:SendDailyMallRewardReceiveReq(callback)
  local function successCallback(_, mapData)
    self.bDailyReward = false
    
    RedDotManager.SetValid(RedDotDefine.Mall_Daily, nil, false)
    local bMall = RedDotManager.GetValid(RedDotDefine.Mall)
    UTILS.OpenReceiveByChangeInfo(mapData)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.daily_mall_reward_receive_req, {}, nil, successCallback)
end

function PlayerMallData:OnEvent_SdkPaySuc(nCode, sMsg, nOrderId, sExData)
  local mapOrder = self._mapOrderId[sExData]
  if mapOrder == nil then
    printError("OrderId not found:" .. sExData)
    return
  end
  local nCacheOrderId = self._mapOrderId[sExData].nOrderId
  local nOrderType = self._mapOrderId[sExData].nType
  local sStatistical = self._mapOrderId[sExData].StatisticalGroup
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  if sStatistical ~= nil then
    if sStatistical == "pack.first" then
      NovaAPI.UserEventUpload("purchase_starterpack", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_first_160")
    elseif sStatistical == "pack.sr" then
      NovaAPI.UserEventUpload("purchase_srtrekkerselect", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_sr_680")
    elseif sStatistical == "pack.role" then
      NovaAPI.UserEventUpload("purchase_newtrekkerpack", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_role_1480")
    elseif sStatistical == "pack.disc" then
      NovaAPI.UserEventUpload("purchase_newdiscpack", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_disc_1480")
    elseif sStatistical == "pack.role_common" then
      NovaAPI.UserEventUpload("purchase_newtrekkerstandard", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_role_common_1280")
    elseif sStatistical == "monthlyCard.small" then
      NovaAPI.UserEventUpload("purchase_monthlycard", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_monthlyCard_small_650")
    elseif sStatistical == "pack_role_m" then
      NovaAPI.UserEventUpload("purchase_monthtrekkervoucher", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_01_role_m_2600")
    elseif sStatistical == "pack_disc_m" then
      NovaAPI.UserEventUpload("purchase_monthdiscvoucher", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_01_disc_m_2600")
    elseif sStatistical == "pack_role_w" then
      NovaAPI.UserEventUpload("purchase_weektrekkerres", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_01_role_w_860")
    elseif sStatistical == "pack_disc_w" then
      NovaAPI.UserEventUpload("purchase_weekdiscres", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_pack_01_disc_w_860")
    elseif sStatistical == "pack_role" then
      NovaAPI.UserEventUpload("purchase_trekkercelebration", tab)
    elseif sStatistical == "pack_gift" then
      NovaAPI.UserEventUpload("purchase_trekkerdessert", tab)
    elseif sStatistical == "pack_disc" then
      NovaAPI.UserEventUpload("purchase_discmusic", tab)
    elseif sStatistical == "pack_res" then
      NovaAPI.UserEventUpload("purchase_trekkerupgrade", tab)
    elseif sStatistical == "pack.op_role" then
      NovaAPI.UserEventUpload("purchase_launchtrekker", tab)
    elseif sStatistical == "pack.op_disc" then
      NovaAPI.UserEventUpload("purchase_launchdisc", tab)
    elseif string.find(sStatistical, "gem") ~= nil then
      NovaAPI.UserEventUpload("purchase_diamond", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_" .. sStatistical)
    elseif sStatistical == "BattlePassPremium" then
      NovaAPI.UserEventUpload("purchase_standardbp", tab)
      PlayerData.Base:UserEventUpload_PC("pc_purchase_battlepass_68_1280")
    elseif sStatistical == "BattlePassOrigin_Luxury" or sStatistical == "BattlePassOrigin_Complement" then
      NovaAPI.UserEventUpload("purchase_deluxebp", tab)
      local tmpEvent = sStatistical == "BattlePassOrigin_Luxury" and "pc_purchase_battlepass_98_1980" or "pc_purchase_battlepass_38_980"
      PlayerData.Base:UserEventUpload_PC(tmpEvent)
    elseif sStatistical == "skin_3d" then
      NovaAPI.UserEventUpload("purchase_skin", tab)
    end
  end
  self._mapOrderId[sExData] = nil
  self:CollectEnqueue(nCacheOrderId, nOrderType)
  self:ProcessOrder()
end

function PlayerMallData:OnEvent_SdkPayFail(nCode, sMsg, nOrderId, sExData, nOrderIdPaying)
  printError("SdkPayFail Msg:" .. sMsg)
  printError("SdkPayFail nCode:" .. nCode)
  local mapOrder = self._mapOrderId[sExData]
  if mapOrder == nil then
    printError("OrderId not found:" .. sExData)
    if sExData == "" and nOrderIdPaying and nOrderIdPaying ~= "" and nOrderIdPaying ~= 0 then
      for k, v in pairs(self._mapOrderId) do
        if v.nOrderId == nOrderIdPaying then
          self._mapOrderId[k] = nil
          break
        end
      end
      self:SendMallOrderCancelReq(nOrderIdPaying, nCode)
    end
    return
  end
  local nCacheOrderId = self._mapOrderId[sExData].nOrderId
  self._mapOrderId[sExData] = nil
  self:SendMallOrderCancelReq(nCacheOrderId, nCode)
end

function PlayerMallData:OnEvent_PayRespone(nCode, sMsg, nOrderId, sExData)
  EventManager.Hit(EventId.BlockInput, false)
  printLog("收到SDK PayRespone")
  local nOrderIdPaying = self._nOrderIdPaying
  self._nOrderIdPaying = nil
  if nCode == 200180 or nCode == 0 or nCode == 201180 then
    self:OnEvent_SdkPaySuc(nCode, sMsg, nOrderId, sExData)
  else
    self:OnEvent_SdkPayFail(nCode, sMsg, nOrderId, sExData, nOrderIdPaying)
  end
end

function PlayerMallData:OnEvent_NewDay()
  self:CacheDailyMallReward(true)
end

function PlayerMallData:OpenOrderWait()
  if MessageBoxManager.CheckOrderWaitOpen() then
    return
  end
  EventManager.Hit("OpenOrderWait")
  self._timerOrderWait = TimerManager.Add(1, 30, self, function()
    self._bWaitTimeOut = true
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Mall_OrderRetry"),
      bDisableSnap = true
    })
    self:CloseOrderWait()
  end, true, true, false)
end

function PlayerMallData:CloseOrderWait()
  if self._timerOrderWait ~= nil then
    self._timerOrderWait:Cancel(false)
    self._timerOrderWait = nil
  end
  if MessageBoxManager.CheckOrderWaitOpen() then
    EventManager.Hit("CloseOrderWait")
  end
end

function PlayerMallData:ProcessOrder(bRetry)
  if self._bProcessingOrder then
    return
  end
  self._bProcessingOrder = true
  self._bRetry = bRetry == true
  if not self._bRetry then
    self:OpenOrderWait()
  end
  self._tbWaitingOrderCollect = {}
  self._mapOrderReward = {
    tbReward = {},
    tbSpReward = {},
    tbSrc = {},
    tbDst = {}
  }
  self:CollectDequeue()
end

function PlayerMallData:SetReCollectTimer()
  if self._timerOrderCollect ~= nil then
    self._timerOrderCollect:Cancel(false)
    self._timerOrderCollect = nil
  end
  if #self._tbOrderCollect > 0 then
    self._timerOrderCollect = TimerManager.Add(1, 2, self, function()
      self:ProcessOrder(true)
    end, true, true, false)
  end
end

function PlayerMallData:CollectDequeue()
  local mapOrder = self._tbOrderCollect[1]
  table.remove(self._tbOrderCollect, 1)
  printLog("当前处理订单：" .. mapOrder.nOrderId)
  if next(self._tbOrderCollect) ~= nil then
    printLog("----预备订单----")
    for _, v in ipairs(self._tbOrderCollect) do
      printLog("订单：" .. v.nOrderId .. "    等待处理")
    end
    printLog("---------------")
  else
    printLog("后续无待处理订单")
  end
  self._mapOrderCollecting = mapOrder
  if mapOrder.nType == AllEnum.RMBOrderType.Mall then
    local function callback(mapData)
      self._mapOrderCollecting = nil
      
      local tbSpReward = PlayerData.CharSkin:GetSkinForReward()
      self:CollectOrder(mapOrder, mapData, tbSpReward)
    end
    
    self:SendMallOrderCollectReq(mapOrder.nOrderId, callback)
  elseif mapOrder.nType == AllEnum.RMBOrderType.BattlePass then
    local function callback(mapData)
      self._mapOrderCollecting = nil
      
      local tbSpReward = PlayerData.CharSkin:GetSkinForReward()
      if mapData.CollectResp then
        PlayerData.BattlePass:OnPremiumBuySuccess(mapData)
        self:CollectOrder(mapOrder, mapData.CollectResp, tbSpReward)
      else
        self:CollectOrder(mapOrder, mapData, tbSpReward)
      end
    end
    
    self:SendBattlePassOrderCollectReq(mapOrder.nOrderId, callback)
  end
end

function PlayerMallData:CollectOrder(mapOrder, mapData, tbSpReward)
  printLog("订单：" .. mapOrder.nOrderId .. "    奖励状态：" .. mapData.Status)
  if mapData.Items and next(mapData.Items) ~= nil then
    local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapData.Items)
    for _, v in pairs(mapReward.tbReward) do
      table.insert(self._mapOrderReward.tbReward, v)
    end
    for _, v in pairs(mapReward.tbSpReward) do
      table.insert(self._mapOrderReward.tbSpReward, v)
    end
    for _, v in pairs(mapReward.tbSrc) do
      table.insert(self._mapOrderReward.tbSrc, v)
    end
    for _, v in pairs(mapReward.tbDst) do
      table.insert(self._mapOrderReward.tbDst, v)
    end
  end
  if tbSpReward and next(tbSpReward) ~= nil then
    for _, v in pairs(tbSpReward) do
      table.insert(self._mapOrderReward.tbSpReward, v)
    end
  end
  if mapData.Status == OrderStatus.Unpaid or mapData.Status == OrderStatus.Retry then
    local bHasWait = false
    for _, v in pairs(self._tbWaitingOrderCollect) do
      if v.nOrderId == mapOrder.nOrderId then
        bHasWait = true
        printError("订单：" .. mapOrder.nOrderId .. "    重复进入等待列表")
        break
      end
    end
    if not bHasWait then
      table.insert(self._tbWaitingOrderCollect, mapOrder)
    end
  end
  if mapData.Status == OrderStatus.Done then
    local tab_1 = {}
    table.insert(tab_1, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    NovaAPI.UserEventUpload("confirm_order", tab_1)
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    NovaAPI.UserEventUpload("purchase_complete", tab)
  end
  if not self._tbOrderCollect or #self._tbOrderCollect == 0 then
    self:CollectEnd(mapData.Status ~= OrderStatus.Done)
  else
    self:CollectDequeue()
  end
end

function PlayerMallData:CollectEnd(bError)
  local function funcClear()
    self._bProcessingOrder = false
    
    self._tbOrderCollect = {}
    if self._bWaitTimeOut then
      self._bWaitTimeOut = false
      for _, mapOrder in pairs(self._tbWaitingOrderCollect) do
        printError("订单：" .. mapOrder.nOrderId .. "    超时订单，需要联系客服，不再请求")
      end
    else
      printLog("----需重新请求的订单----")
      for _, mapOrder in pairs(self._tbWaitingOrderCollect) do
        table.insert(self._tbOrderCollect, mapOrder)
        printLog("订单：" .. mapOrder.nOrderId .. "    未成功，重新进入订单列表")
      end
      printLog("---------------")
    end
    self._tbWaitingOrderCollect = {}
    if next(self._tbOrderCollect) == nil then
      local bMoney = true
      EventManager.Hit("MallOrderClear", bMoney)
    end
    self:SetReCollectTimer()
  end
  
  if not bError then
    self:CloseOrderWait()
  end
  local bInAdventure = ModuleManager.GetIsAdventure()
  if PanelManager.CheckPanelOpen(PanelId.ReceiveAutoTrans) == true or PanelManager.CheckPanelOpen(PanelId.ReceivePropsTips) == true or PanelManager.CheckPanelOpen(PanelId.ReceivePropsNPC) == true or PanelManager.CheckPanelOpen(PanelId.ReceiveSpecialReward) == true or PanelManager.CheckNextPanelOpening() or bInAdventure == true then
    funcClear()
  else
    local sTip
    if self._bRetry and self._bWaitTimeOut then
      sTip = ConfigTable.GetUIText("Mall_OrderDelayed")
    end
    UTILS.OpenReceiveByReward(self._mapOrderReward, funcClear, sTip)
  end
end

function PlayerMallData:CollectEnqueue(nOrderId, nType)
  if not self._tbOrderCollect then
    self._tbOrderCollect = {}
  end
  if self._bProcessingOrder and #self._tbOrderCollect == 0 then
    local bHasWait = false
    for _, v in pairs(self._tbWaitingOrderCollect) do
      if v.nOrderId == nOrderId then
        bHasWait = true
        printError("订单：" .. nOrderId .. "    重复进入等待列表")
        break
      end
    end
    if not bHasWait then
      table.insert(self._tbWaitingOrderCollect, {nOrderId = nOrderId, nType = nType})
    end
    return
  end
  table.insert(self._tbOrderCollect, {nOrderId = nOrderId, nType = nType})
end

function PlayerMallData:SendBattlePassOrderReq(nMode, nVersion, callback)
  local mapMsg = {Mode = nMode, Version = nVersion}
  
  local function successCallback(_, mapData)
    printLog("创建订单：" .. mapData.Id)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.battle_pass_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendMallGemListReq(callback)
  local function successCallback(_, mapData)
    callback(mapData.List)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_gem_list_req, {}, nil, successCallback)
end

function PlayerMallData:SendMallGemOrderReq(sId, callback)
  if type(sId) == "number" then
    sId = tostring(sId)
  end
  local mapMsg = {Value = sId}
  
  local function successCallback(_, mapData)
    printLog("创建订单：" .. mapData.Id)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_gem_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendMallOrderCancelReq(nId, nCode, callback)
  local tbCancelCode = {
    200154,
    200230,
    200340,
    200500,
    200600,
    201236,
    101606,
    101731,
    201230,
    201221,
    201223,
    201224
  }
  if table.indexof(tbCancelCode, nCode) == 0 then
    local bMoney = true
    EventManager.Hit("MallOrderClear", bMoney)
    return
  end
  printLog("订单取消")
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Alert,
    sContent = ConfigTable.GetUIText("Mall_OrderCancel")
  })
  local bMoney = true
  EventManager.Hit("MallOrderClear", bMoney)
end

function PlayerMallData:SendMallOrderCollectReq(nId, callback)
  if type(nId) == "number" then
    nId = tostring(nId)
  end
  local mapMsg = {Value = nId}
  
  local function successCallback(_, mapData)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_order_collect_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendBattlePassOrderCollectReq(nId, callback)
  if type(nId) == "number" then
    nId = tostring(nId)
  end
  local mapMsg = {Value = nId}
  
  local function successCallback(_, mapData)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.battle_pass_order_collect_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendMallMonthlyCardListReq(callback)
  local function successCallback(_, mapData)
    table.sort(mapData.List, function(a, b)
      local mapCfgA = ConfigTable.GetData("MallMonthlyCard", a.Id)
      
      local mapCfgB = ConfigTable.GetData("MallMonthlyCard", b.Id)
      if mapCfgA == nil or mapCfgB == nil then
        return false
      end
      return mapCfgA.MonthlyCardId < mapCfgB.MonthlyCardId
    end)
    callback(mapData.List)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_monthlyCard_list_req, {}, nil, successCallback)
end

function PlayerMallData:SendMallMonthlyCardOrderReq(sId, callback)
  local mapMsg = {Value = sId}
  
  local function successCallback(_, mapData)
    printLog("创建订单：" .. mapData.Id)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_monthlyCard_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendMallActivityListReq(callback)
  local function successCallback(_, mapData)
    self._mapActivityProduct = {}
    
    for _, v in ipairs(mapData.List or {}) do
      self._mapActivityProduct[v.Id] = v
    end
    if callback ~= nil then
      callback(self._mapActivityProduct)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_activity_list_req, {}, nil, successCallback)
end

function PlayerMallData:SendMallActivityOrderReq(sId, callback)
  if type(sId) == "number" then
    sId = tostring(sId)
  end
  local mapMsg = {Value = sId}
  
  local function successCallback(_, mapData)
    printLog("创建订单：" .. mapData.Id)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_activity_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendWeeklyCardOrderReq(sId, callback)
  local mapMsg = {Value = sId}
  
  local function successCallback(_, mapData)
    printLog("创建订单：" .. mapData.Id)
    callback(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_card_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:CacheMallPackageList()
  local function callback(_, _)
  end
  
  self:SendMallPackageListReq(callback)
end

function PlayerMallData:SendMallPackageListReq(callback)
  local function successCallback(_, mapData)
    self:UpdateNextMallPackage()
    
    local tbPackageList = self:ParsePackageList(mapData.List)
    local nAutoTime = self:CalPackageAutoTime(tbPackageList)
    self._tbPackage = tbPackageList
    callback(tbPackageList, nAutoTime)
    self:UpdateMallRedDot(tbPackageList)
    self:ResetPackageNew()
    self:UpdateMallPackageRedDot(tbPackageList)
    self:ClearDelistedSkinTrialRedDot()
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_package_list_req, {}, nil, successCallback)
end

function PlayerMallData:SendMallPackageOrderReq(sId, callback)
  local mapMsg = {Value = sId}
  
  local function successCallback(_, mapData)
    if mapData.Order then
      printLog("创建订单：" .. mapData.Order.Id)
      callback(mapData.Order)
    else
      UTILS.OpenReceiveByChangeInfo(mapData.Change)
      local bMoney = false
      EventManager.Hit("MallOrderClear", bMoney)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_package_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendMallReengagementPackageOrderReq(sId, callback)
  local mapMsg = {Value = sId}
  
  local function successCallback(_, mapData)
    if mapData ~= nil then
      printLog("创建订单：" .. mapData.Id)
      callback(mapData)
    else
      UTILS.OpenReceiveByChangeInfo(mapData.Change)
      local bMoney = false
      EventManager.Hit("MallOrderClear", bMoney)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_returnee_pack_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendMallShopListReq(callback)
  local function successCallback(_, mapData)
    self:UpdateNextMallShop()
    
    local tbList = self:ParseShopList(mapData.List)
    local nAutoTime = self:CalShopAutoTime(tbList)
    callback(tbList, nAutoTime)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_shop_list_req, {}, nil, successCallback)
end

function PlayerMallData:SendMallShopOrderReq(sId, nCount)
  local mapMsg = {Id = sId, Qty = nCount}
  
  local function successCallback(_, mapData)
    UTILS.OpenReceiveByChangeInfo(mapData)
    local bMoney = false
    EventManager.Hit("MallOrderClear", bMoney)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.mall_shop_order_req, mapMsg, nil, successCallback)
end

function PlayerMallData:SendCharFragmentConvertReq(callBack)
  local mapMsg = {}
  HttpNetHandler.SendMsg(NetMsgId.Id.fragments_convert_req, mapMsg, nil, callBack)
end

function PlayerMallData:ProcessOrderPaidNotify(mapData)
  if self._mapOrderCollecting and self._mapOrderCollecting.nOrderId == mapData.OrderId then
    return
  end
  local nType = AllEnum.RMBOrderType.Mall
  if mapData.Store == 3 then
    nType = AllEnum.RMBOrderType.BattlePass
  end
  self:CollectEnqueue(mapData.OrderId, nType)
  self:ProcessOrder()
end

function PlayerMallData:UpdateMallRedDot(tbPackageList)
  local bCheck = false
  for _, mallData in ipairs(tbPackageList) do
    local mapCfg = ConfigTable.GetData("MallPackage", mallData.sId)
    if nil ~= mapCfg and mapCfg.CurrencyType == GameEnum.currencyType.Free then
      local tbCond = decodeJson(mapCfg.OrderCondParams)
      local bPurchaseAble = PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, tbCond)
      if mallData.nCurStock > 0 and bPurchaseAble then
        bCheck = true
        RedDotManager.SetValid(RedDotDefine.FreePackage, {
          mallData.sId
        }, true)
      else
        RedDotManager.SetValid(RedDotDefine.FreePackage, {
          mallData.sId
        }, false)
      end
    end
  end
  RedDotManager.SetValid(RedDotDefine.Mall_Free, nil, bCheck)
  EventManager.Hit("Mall_Refresh_Reddot")
end

function PlayerMallData:ResetPackageNew()
  local function foreachFunc(mapCfg)
    local groupCfg = ConfigTable.GetData("MallPackagePage", mapCfg.GroupId, true)
    
    if groupCfg == nil then
      return
    end
    local nTog = self:GetPackageToggle(mapCfg.Tag)
    if nTog == nil then
      return
    end
    RedDotManager.SetValid(RedDotDefine.Mall_Package_New, {
      nTog,
      groupCfg.Sort,
      mapCfg.Id
    }, false)
  end
  
  ForEachTableLine(DataTable.MallPackage, foreachFunc)
end

function PlayerMallData:ClearDelistedSkinTrialRedDot()
  local nCurTime = ClientManager.serverTimeStamp
  
  local function foreachFunc(mapCfg)
    if mapCfg.Tag ~= GameEnum.MallItemType.Skin then
      return
    end
    local nDeListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfg.DeListTime)
    if nDeListTime <= 0 or nDeListTime > nCurTime then
      return
    end
    PlayerData.Char:ClearCharSkinTrialRedDot(mapCfg.Id)
  end
  
  ForEachTableLine(DataTable.MallPackage, foreachFunc)
end

function PlayerMallData:RemovePackageNew(nPage, nSort)
  if nSort == 0 then
    return
  end
  if #self._tbPackage == 0 then
    return
  end
  local nTog = self:GetPackageToggle(nPage)
  if nTog == nil then
    return
  end
  for _, v in pairs(self._tbPackage) do
    local mapCfg = ConfigTable.GetData("MallPackage", v.sId)
    local groupCfg = mapCfg ~= nil and ConfigTable.GetData("MallPackagePage", mapCfg.GroupId)
    if groupCfg and mapCfg.Tag == nPage and groupCfg.Sort == nSort then
      RedDotManager.SetValid(RedDotDefine.Mall_Package_New, {
        nTog,
        groupCfg.Sort,
        mapCfg.Id
      }, false)
      local sCheckNew = LocalData.GetPlayerLocalData("Mall_Package_New") or ""
      local tbCheckNew = string.split(sCheckNew, ",")
      if table.indexof(tbCheckNew, mapCfg.Id) == 0 then
        sCheckNew = sCheckNew .. "," .. mapCfg.Id
        LocalData.SetPlayerLocalData("Mall_Package_New", sCheckNew)
      end
    end
  end
  EventManager.Hit("Mall_Refresh_Reddot")
end

function PlayerMallData:UpdateMallPackageRedDot(tbPackageList)
  local sCheckNew = LocalData.GetPlayerLocalData("Mall_Package_New") or ""
  local tbCheckNew = string.split(sCheckNew, ",")
  for _, mallData in ipairs(tbPackageList) do
    local mapCfg = ConfigTable.GetData("MallPackage", mallData.sId)
    if nil ~= mapCfg and mapCfg.IsNew then
      local tbCond = decodeJson(mapCfg.OrderCondParams)
      local bPurchaseAble = PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, tbCond)
      local bNotNew = table.indexof(tbCheckNew, mallData.sId) ~= 0
      local groupCfg = ConfigTable.GetData("MallPackagePage", mapCfg.GroupId)
      if groupCfg == nil then
        return
      end
      local nTog = self:GetPackageToggle(mapCfg.Tag)
      if nTog ~= nil then
        local bNew = 0 < mallData.nCurStock and bPurchaseAble and not bNotNew
        RedDotManager.SetValid(RedDotDefine.Mall_Package_New, {
          nTog,
          groupCfg.Sort,
          mallData.sId
        }, bNew)
      end
    end
  end
  EventManager.Hit("Mall_UpdateMallPackageRedDot")
end

return PlayerMallData
