local PlayerShopData = class("PlayerShopData")
local ClientManager = CS.ClientManager.Instance
local DisplayMode = {
  Hide = 0,
  End = 1,
  Stay = 2
}

function PlayerShopData:Init()
  self._tbShops = {}
  self._tbGoods = {}
  self._tbServerData = {}
  self._bFirstInShop = true
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Add(EventId.NewFuncUnlockWorldClass, self, self.OnEvent_NewFuncUnlockWorldClass)
end

function PlayerShopData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Remove(EventId.NewFuncUnlockWorldClass, self, self.OnEvent_NewFuncUnlockWorldClass)
end

function PlayerShopData:OnEvent_NewDay()
  self:CacheDailyShopReward(true)
end

function PlayerShopData:OnEvent_NewFuncUnlockWorldClass(nId)
  if nId == GameEnum.OpenFuncType.DailyReward then
    self:CacheDailyShopReward(true)
  end
end

function PlayerShopData:CheckShopData(callback)
  if next(self._tbShops) == nil then
    local function func_create()
      self:CreateData()
      
      if callback then
        callback()
      end
    end
    
    self:SendResidentShopGetReq({}, func_create)
  else
    local tbShopIds = self:GetNeedToRefreshShops()
    if 0 < #tbShopIds then
      local function func_update()
        self:UpdateData(tbShopIds)
        
        if callback then
          callback()
        end
      end
      
      self:SendResidentShopGetReq(tbShopIds, func_update)
    elseif callback then
      callback()
    end
  end
end

function PlayerShopData:CheckGoodsData(nShopId)
  local tbGoods = self:GetNeedToRefreshGoods(nShopId)
  if #tbGoods == 0 then
    return
  end
  local nServerTimeStamp = ClientManager.serverTimeStamp
  for _, mapGoods in pairs(tbGoods) do
    if mapGoods.nDownShelfTime ~= 0 and nServerTimeStamp >= mapGoods.nDownShelfTime then
      self._tbGoods[nShopId][mapGoods.nId] = nil
    else
      self:UpdateGoodsData(nShopId, mapGoods.nId)
    end
  end
end

function PlayerShopData:GetShopList()
  local tbList = {}
  for _, mapShop in pairs(self._tbShops) do
    if mapShop.bUnlock and mapShop.bOpenAble and mapShop.nType == GameEnum.ShopType.Resident then
      table.insert(tbList, mapShop)
    end
  end
  table.sort(tbList, function(a, b)
    return a.nSequence < b.nSequence
  end)
  return tbList
end

function PlayerShopData:GetShopListByType(nType)
  local tbList = {}
  for _, mapShop in pairs(self._tbShops) do
    if mapShop.bUnlock and mapShop.bOpenAble and mapShop.nType == nType then
      table.insert(tbList, mapShop)
    end
  end
  table.sort(tbList, function(a, b)
    return a.nSequence < b.nSequence
  end)
  return tbList
end

function PlayerShopData:GetGoodsList(nShopId)
  local tbList = {}
  for _, mapGoods in pairs(self._tbGoods[nShopId]) do
    if mapGoods.bUnlock and mapGoods.bOpenAble and (not mapGoods.bSoldOut or mapGoods.nDisplayMode ~= DisplayMode.Hide) then
      table.insert(tbList, mapGoods)
    end
  end
  
  local function comp(a, b)
    if (a.bSoldOut and a.nDisplayMode == DisplayMode.End) ~= (b.bSoldOut and b.nDisplayMode == DisplayMode.End) then
      return (not a.bSoldOut or a.nDisplayMode ~= DisplayMode.End) and b.bSoldOut and b.nDisplayMode == DisplayMode.End
    else
      return a.nSaleNumber < b.nSaleNumber
    end
  end
  
  table.sort(tbList, comp)
  return tbList
end

function PlayerShopData:GetShopAutoUpdateTime()
  local tbTime = {}
  for _, mapShop in pairs(self._tbShops) do
    if mapShop.nNextRefreshTime > 0 then
      table.insert(tbTime, mapShop.nNextRefreshTime)
    end
  end
  if #tbTime == 0 then
    return 0
  end
  table.sort(tbTime)
  return tbTime[1] - ClientManager.serverTimeStamp
end

function PlayerShopData:GetGoodsAutoUpdateTime(nShopId)
  local tbTime = {}
  for _, mapGoods in pairs(self._tbGoods[nShopId]) do
    if mapGoods.nNextRefreshTime > 0 then
      table.insert(tbTime, mapGoods.nNextRefreshTime)
    end
  end
  if #tbTime == 0 then
    return 0
  end
  table.sort(tbTime)
  return tbTime[1] - ClientManager.serverTimeStamp
end

function PlayerShopData:GetShopFirstIn()
  local bFirst = self._bFirstInShop
  if self._bFirstInShop == true then
    self._bFirstInShop = false
  end
  return bFirst
end

function PlayerShopData:CheckShopJumpAble(nShopId)
  local sLockTip = ""
  local mapCfg = ConfigTable.GetData("ResidentShop", nShopId)
  if not mapCfg then
    return false, sLockTip
  end
  if mapCfg.UnlockCondType == GameEnum.shopCond.WorldClassSpecific then
    local worldClass = PlayerData.Base:GetWorldClass()
    local tbParams = decodeJson(mapCfg.UnlockCondParams)
    local bAble = worldClass >= tbParams[1]
    sLockTip = orderedFormat(ConfigTable.GetUIText("Shop_Cond_WorldClass"), tbParams[1])
    return bAble, sLockTip
  end
  return true, sLockTip
end

function PlayerShopData:CreateData()
  local nServerTimeStamp = ClientManager.serverTimeStamp
  
  local function func_ForEach_Shop(mapCfgData)
    self:CreateShopData(mapCfgData, nServerTimeStamp)
  end
  
  ForEachTableLine(DataTable.ResidentShop, func_ForEach_Shop)
  
  local function func_ForEach_Goods(mapCfgData)
    if self._tbShops[mapCfgData.ShopId] then
      self:CreateGoodsData(mapCfgData, nServerTimeStamp)
    end
  end
  
  ForEachTableLine(DataTable.ResidentGoods, func_ForEach_Goods)
end

function PlayerShopData:CreateShopData(mapCfgData, nServerTimeStamp)
  local nCloseTime = self:ChangeToTimeStamp(mapCfgData.CloseTime)
  local bExpired = nCloseTime ~= 0 and nServerTimeStamp >= nCloseTime
  if bExpired then
    return
  end
  local mapShop = {
    nId = mapCfgData.Id,
    tbShopCoin = mapCfgData.ShopCoin,
    sName = mapCfgData.Name,
    nSequence = mapCfgData.Sequence,
    nRefreshTimeType = mapCfgData.RefreshTimeType,
    nRefreshInterval = mapCfgData.RefreshInterval,
    nUnlockCondType = mapCfgData.UnlockCondType,
    tbUnlockCondParams = decodeJson(mapCfgData.UnlockCondParams),
    nOpenTime = self:ChangeToTimeStamp(mapCfgData.OpenTime),
    nCloseTime = nCloseTime,
    bUnlock = false,
    bOpenAble = false,
    nServerRefreshTime = 0,
    nNextRefreshTime = 0,
    nType = mapCfgData.Type
  }
  self._tbShops[mapCfgData.Id] = mapShop
  self:UpdateShopData(mapCfgData.Id)
end

function PlayerShopData:CreateGoodsData(mapCfgData, nServerTimeStamp)
  local nDownShelfTime = self:ChangeToTimeStamp(mapCfgData.DownShelfTime)
  local bExpired = nDownShelfTime ~= 0 and nServerTimeStamp >= nDownShelfTime
  if bExpired then
    return
  end
  local mapGoods = {
    nId = mapCfgData.Id,
    sName = mapCfgData.Name,
    sDesc = mapCfgData.Desc,
    nSaleNumber = mapCfgData.SaleNumber,
    nItemId = mapCfgData.ItemId,
    nItemQuantity = mapCfgData.ItemQuantity,
    nMaximumLimit = mapCfgData.MaximumLimit,
    nCurrencyItemId = mapCfgData.CurrencyItemId,
    nPrice = mapCfgData.Price,
    nOriginalPrice = mapCfgData.OriginalPrice,
    nDiscount = mapCfgData.Discount,
    nAppearCondType = mapCfgData.AppearCondType,
    tbAppearCondParams = decodeJson(mapCfgData.AppearCondParams),
    nPurchaseCondType = mapCfgData.PurchaseCondType,
    tbPurchaseCondParams = decodeJson(mapCfgData.PurchaseCondParams),
    nUpShelfTime = self:ChangeToTimeStamp(mapCfgData.UpShelfTime),
    nDownShelfTime = nDownShelfTime,
    nUnlockPurchaseTime = self:ChangeToTimeStamp(mapCfgData.UnlockPurchaseTime),
    nDisplayMode = mapCfgData.DisplayMode,
    bUnlock = false,
    bPurchasable = false,
    bPurchasTime = false,
    bOpenAble = false,
    bSoldOut = false,
    nBoughtCount = 0,
    nNextRefreshTime = 0
  }
  if not self._tbGoods[mapCfgData.ShopId] then
    self._tbGoods[mapCfgData.ShopId] = {}
  end
  self._tbGoods[mapCfgData.ShopId][mapCfgData.Id] = mapGoods
  self:UpdateGoodsData(mapCfgData.ShopId, mapCfgData.Id)
end

function PlayerShopData:ChangeToTimeStamp(sTime)
  return sTime == "" and 0 or ClientManager:ISO8601StrToTimeStamp(sTime)
end

function PlayerShopData:UpdateData(tbShopIds)
  local nServerTimeStamp = ClientManager.serverTimeStamp
  for _, nShopId in pairs(tbShopIds) do
    if self._tbShops[nShopId].nCloseTime ~= 0 and nServerTimeStamp >= self._tbShops[nShopId].nCloseTime then
      self._tbShops[nShopId] = nil
      self._tbGoods[nShopId] = nil
    else
      self:UpdateShopData(nShopId)
      for nGoodsId, mapGoods in pairs(self._tbGoods[nShopId]) do
        if mapGoods.nDownShelfTime ~= 0 and nServerTimeStamp >= mapGoods.nDownShelfTime then
          self._tbGoods[nShopId][nGoodsId] = nil
        else
          self:UpdateGoodsData(nShopId, nGoodsId)
        end
      end
    end
  end
end

function PlayerShopData:UpdateShopData(nId)
  self._tbShops[nId].bUnlock = self:CheckShopCond(self._tbShops[nId].nUnlockCondType, self._tbShops[nId].tbUnlockCondParams)
  self._tbShops[nId].bOpenAble = ClientManager.serverTimeStamp >= self._tbShops[nId].nOpenTime
  self._tbShops[nId].nServerRefreshTime = self._tbServerData[nId] and self._tbServerData[nId].RefreshTime or 0
  self._tbShops[nId].nNextRefreshTime = self:UpdateNextShopRefreshTime(nId, self._tbShops[nId].nServerRefreshTime)
end

function PlayerShopData:UpdateGoodsData(nShopId, nGoodsId)
  local mapGoods = self._tbGoods[nShopId][nGoodsId]
  local nBoughtCount = self:GetBoughtCount(nGoodsId)
  self._tbGoods[nShopId][nGoodsId].bUnlock = self:CheckShopCond(mapGoods.nAppearCondType, mapGoods.tbAppearCondParams, AllEnum.ShopCondSource.ResidentGoods)
  self._tbGoods[nShopId][nGoodsId].bPurchasable = self:CheckShopCond(mapGoods.nPurchaseCondType, mapGoods.tbPurchaseCondParams, AllEnum.ShopCondSource.ResidentGoods)
  self._tbGoods[nShopId][nGoodsId].bPurchasTime = ClientManager.serverTimeStamp >= mapGoods.nUnlockPurchaseTime
  self._tbGoods[nShopId][nGoodsId].bOpenAble = ClientManager.serverTimeStamp >= mapGoods.nUpShelfTime
  self._tbGoods[nShopId][nGoodsId].bSoldOut = nBoughtCount ~= 0 and nBoughtCount == mapGoods.nMaximumLimit
  self._tbGoods[nShopId][nGoodsId].nBoughtCount = nBoughtCount
  self._tbGoods[nShopId][nGoodsId].nNextRefreshTime = self:UpdateNextGoodsRefreshTime(nShopId, nGoodsId)
end

function PlayerShopData:UpdateNextShopRefreshTime(nId, nServerRefreshTime)
  local mapShop = self._tbShops[nId]
  if mapShop.nOpenTime > 0 then
    local nTime = mapShop.nOpenTime
    if 0 < nTime - ClientManager.serverTimeStamp then
      return nTime
    end
  end
  local nNextRefreshTime = 0
  if 0 < mapShop.nCloseTime then
    local nTime = mapShop.nCloseTime
    nNextRefreshTime = nTime
  end
  if 0 < mapShop.nRefreshTimeType then
    local nTime = nServerRefreshTime
    nNextRefreshTime = (nNextRefreshTime == 0 or nNextRefreshTime > nTime) and nTime or nNextRefreshTime
  end
  return nNextRefreshTime
end

function PlayerShopData:UpdateNextGoodsRefreshTime(nShopId, nGoodsId)
  local mapGoods = self._tbGoods[nShopId][nGoodsId]
  if mapGoods.nUpShelfTime > 0 then
    local nTime = mapGoods.nUpShelfTime
    if 0 < nTime - ClientManager.serverTimeStamp then
      return nTime
    end
  end
  local nNextRefreshTime = 0
  if 0 < mapGoods.nDownShelfTime then
    local nTime = mapGoods.nDownShelfTime
    nNextRefreshTime = nTime
  end
  if 0 < mapGoods.nUnlockPurchaseTime then
    local nTime = mapGoods.nUnlockPurchaseTime
    nNextRefreshTime = (nNextRefreshTime == 0 or nNextRefreshTime > nTime) and nTime or nNextRefreshTime
  end
  return nNextRefreshTime
end

function PlayerShopData:ProcessServerData(mapServerData)
  for _, mapShop in ipairs(mapServerData) do
    self._tbServerData[mapShop.Id] = {}
    self._tbServerData[mapShop.Id].RefreshTime = mapShop.RefreshTime or 0
    for _, mapBoughtGoods in ipairs(mapShop.Infos) do
      self._tbServerData[mapShop.Id][mapBoughtGoods.Id] = mapBoughtGoods.Number
    end
  end
end

function PlayerShopData:GetBoughtCount(nGoodsId)
  local mapGoods = ConfigTable.GetData("ResidentGoods", nGoodsId)
  if mapGoods == nil then
    printError("商品配置不存在" .. nGoodsId)
    return 0
  end
  local nShopId = mapGoods.ShopId
  if self._tbServerData[nShopId] and self._tbServerData[nShopId][nGoodsId] then
    return self._tbServerData[nShopId][nGoodsId]
  else
    return 0
  end
end

function PlayerShopData:CacheDailyShopReward(bDailyReward)
  local bUnlock = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.DailyReward)
  self.bDailyReward = bUnlock and bDailyReward
  RedDotManager.SetValid(RedDotDefine.Shop_Daily, nil, self.bDailyReward)
end

function PlayerShopData:GetDailyShopReward()
  return self.bDailyReward
end

function PlayerShopData:GetNeedToRefreshShops()
  local tbShopIds = {}
  local nServerTimeStamp = ClientManager.serverTimeStamp
  for _, mapShop in pairs(self._tbShops) do
    if not mapShop.bUnlock then
      local bUnlock = self:CheckShopCond(mapShop.nUnlockCondType, mapShop.tbUnlockCondParams)
      if bUnlock then
        table.insert(tbShopIds, mapShop.nId)
      end
    elseif mapShop.nNextRefreshTime > 0 and nServerTimeStamp >= mapShop.nNextRefreshTime then
      table.insert(tbShopIds, mapShop.nId)
    end
  end
  return tbShopIds
end

function PlayerShopData:GetNeedToRefreshGoods(nShopId)
  local tbGoods = {}
  local nServerTimeStamp = ClientManager.serverTimeStamp
  if self._tbGoods[nShopId] then
    for _, mapGoods in pairs(self._tbGoods[nShopId]) do
      if not mapGoods.bUnlock then
        local bUnlock = self:CheckShopCond(mapGoods.nAppearCondType, mapGoods.tbAppearCondParams, AllEnum.ShopCondSource.ResidentGoods)
        if bUnlock then
          table.insert(tbGoods, mapGoods)
        end
      elseif not mapGoods.bPurchasable then
        local bPurchasable = self:CheckShopCond(mapGoods.nPurchaseCondType, mapGoods.tbPurchaseCondParams, AllEnum.ShopCondSource.ResidentGoods)
        if bPurchasable then
          table.insert(tbGoods, mapGoods)
        end
      elseif mapGoods.nNextRefreshTime > 0 and nServerTimeStamp >= mapGoods.nNextRefreshTime then
        table.insert(tbGoods, mapGoods)
      end
    end
  end
  return tbGoods
end

function PlayerShopData:CheckShopCond(eCond, tbParam, nType)
  if eCond == 0 then
    return true
  elseif eCond == GameEnum.shopCond.WorldClassSpecific and #tbParam == 1 then
    local worldClass = PlayerData.Base:GetWorldClass()
    return worldClass >= tbParam[1]
  elseif eCond == GameEnum.shopCond.ShopPreGoodsSellOut and #tbParam == 2 and nType == AllEnum.ShopCondSource.ResidentGoods then
    local nBeforeId = tbParam[2]
    local nBoughtCount = self:GetBoughtCount(nBeforeId)
    local mapCfg = ConfigTable.GetData("ResidentGoods", nBeforeId)
    if not mapCfg then
      return false
    end
    local bSoldOut = nBoughtCount ~= 0 and nBoughtCount == mapCfg.MaximumLimit
    return bSoldOut
  else
    printError("条件配置错误：")
    return false
  end
end

function PlayerShopData:SendResidentShopGetReq(tbShopIds, callback)
  local mapMsg = {ShopIds = tbShopIds}
  
  local function successCallback(_, mapData)
    if mapData.Shops then
      self:ProcessServerData(mapData.Shops)
      callback()
    else
      printError("商店数据为空")
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.resident_shop_get_req, mapMsg, nil, successCallback)
end

function PlayerShopData:SendResidentShopPurchaseReq(nShopId, nGoodsId, nCount, callback)
  local mapMsg = {
    GoodsId = nGoodsId,
    Number = nCount,
    RefreshTime = self._tbShops[nShopId].nServerRefreshTime,
    ShopId = nShopId
  }
  
  local function successCallback(_, mapData)
    if mapData.IsRefresh then
      self:ProcessServerData({
        mapData.Shop
      })
      EventManager.Hit("ShopTimeRefresh")
    else
      if not self._tbServerData[nShopId] then
        self._tbServerData[nShopId] = {}
      end
      self._tbServerData[nShopId][nGoodsId] = mapData.PurchasedNumber
    end
    self:UpdateData({nShopId})
    UTILS.OpenReceiveByChangeInfo(mapData.Change)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.resident_shop_purchase_req, mapMsg, nil, successCallback)
end

function PlayerShopData:SendDailyShopRewardReceiveReq(callback)
  local function successCallback(_, mapData)
    self.bDailyReward = false
    
    RedDotManager.SetValid(RedDotDefine.Shop_Daily, nil, false)
    UTILS.OpenReceiveByChangeInfo(mapData)
    if callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.daily_shop_reward_receive_req, {}, nil, successCallback)
end

return PlayerShopData
