local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessStoreCtrl = class("WarChessStoreCtrl", base)
local ChipData = require("Game.PlayerData.Item.ChipData")
local BuffData = require("Game.WarChess.Data.WarChessBuffData")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function WarChessStoreCtrl:ctor(wcCtrl)
  self.__storeSystemData = nil
  self.__identify = nil
  self.__storeDataList = nil
  self.wcCtrl = wcCtrl
end

function WarChessStoreCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.shop
end

function WarChessStoreCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.storeSystemData == nil then
    error("not have data")
    return
  end
  self.__storeSystemData = systemState.storeSystemData
  self.__identify = identify
  self.__curTeamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamUid(identify.tid)
  self:__DealStoreData()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessStore, function(win)
    if win == nil then
      return
    end
    win:InitWCChipStore(self)
  end)
end

function WarChessStoreCtrl:__DealStoreData()
  self.__storeChipDataList = {}
  for index, elem in ipairs(self.__storeSystemData.storeElem) do
    local storeData = {}
    storeData.idx = index - 1
    storeData.id = elem.algId
    storeData.discount = 100
    storeData.saled = elem.purchased
    local alg = elem.alg
    local itemId, level = ExplorationManager.ChipServerIdConvert(alg)
    local chipCfg = ConfigData.chip[itemId]
    if chipCfg == nil then
      error("Can't find chip cfg, id = " .. tostring(itemId))
    else
      if chipCfg.type == ChipEnum.eChipType.Buff then
        error("storeElem not support buff yet")
      else
        local chipData = ChipData.NewChipForLocal(itemId, level)
        if self.__storeSystemData.buffRate ~= nil then
          chipData.wcChipServerBuyRate = 1 + self.__storeSystemData.buffRate / 10000
        end
        chipData.wcBuffServerBuyPriceAdd = self.__storeSystemData.buffPrice or 0
        storeData.chipData = chipData
      end
      table.insert(self.__storeChipDataList, storeData)
    end
  end
  if self.__storeSystemData.buffElem ~= nil then
    self.__storeBuffDataList = {}
    for index, elem in ipairs(self.__storeSystemData.buffElem) do
      local storeData = {}
      storeData.idx = index
      storeData.id = elem.buffId
      storeData.discount = 100
      storeData.saled = elem.purchased
      local alg = elem.buffId
      local chipCfg = ConfigData.chip[alg]
      if chipCfg == nil then
        error("Can't find chip cfg, id = " .. tostring(alg))
      else
        if chipCfg.type == ChipEnum.eChipType.WarChessBuff then
          local buffData = BuffData.CrearteBuffById(alg)
          storeData.epBuffData = buffData
        else
          error("buffElem not support chip yet")
        end
        table.insert(self.__storeBuffDataList, storeData)
      end
    end
  end
end

function WarChessStoreCtrl:GetWCChipDataList()
  return self.__storeChipDataList
end

function WarChessStoreCtrl:GetWCBuffDataList()
  return self.__storeBuffDataList
end

function WarChessStoreCtrl:GetWCCoinItemIconId()
  local cfg = ConfigData.item[ConstGlobalItem.WCMoney]
  return cfg ~= nil and cfg.icon or nil
end

function WarChessStoreCtrl:GetWCCoinItemNum()
  return self.wcCtrl.backPackCtrl:GetWCCoinNum()
end

function WarChessStoreCtrl:GetWCRareItemIconId()
  local cfg = ConfigData.item[ConstGlobalItem.WCDeployPoint]
  return cfg ~= nil and cfg.icon or nil
end

function WarChessStoreCtrl:GetWCRareItemNum()
  return self.wcCtrl.backPackCtrl:GetWCDeployPointNum()
end

function WarChessStoreCtrl:GetRefreshTime()
  if self.__storeSystemData ~= nil then
    return self.__storeSystemData.refreshTime
  end
end

function WarChessStoreCtrl:GetCoinExchangeIsUse()
  local leftNumDic = self.__storeSystemData.buyItemNum
  local rare2coin = ConstGlobalItem.WCDeployPoint << 32 | ConstGlobalItem.WCMoney
  local isRunOut = (leftNumDic[rare2coin] or 0) <= 0
  return isRunOut
end

function WarChessStoreCtrl:GetRareExchangeIsUse()
  local leftNumDic = self.__storeSystemData.buyItemNum
  local coin2rare = ConstGlobalItem.WCMoney << 32 | ConstGlobalItem.WCDeployPoint
  local isRunOut = (leftNumDic[coin2rare] or 0) <= 0
  return isRunOut
end

function WarChessStoreCtrl:GetExChangeItemID(itemId)
  local costItemID = -1
  if itemId == ConstGlobalItem.WCMoney then
    costItemID = ConstGlobalItem.WCDeployPoint
  elseif itemId == ConstGlobalItem.WCDeployPoint then
    costItemID = ConstGlobalItem.WCMoney
  end
  return costItemID
end

function WarChessStoreCtrl:GetWarChessStoreRefreshPrice()
  local shopId = WarChessManager:GetWCLevelShopId()
  local refreshTimes = self:GetRefreshTime()
  local refreshCostBaseNum = ConfigData.warchess_shop_coin[shopId].init_fresh_price
  local refreshIncreaseNum = ConfigData.warchess_shop_coin[shopId].increase_fresh_price
  local result = refreshCostBaseNum + refreshIncreaseNum * refreshTimes
  return result
end

function WarChessStoreCtrl:WCBuyChip(storeData, teamUid, callback)
  local idx = storeData.idx
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_StoreSystem_SelectAlg(self.__identify, idx, teamUid, function()
    storeData.saled = true
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessStoreCtrl:WCSaleChip(chipId, teamUid, callback)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_StoreSystem_SaleAlg(self.__identify, chipId, teamUid, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessStoreCtrl:WCRefresh(callback)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_StoreSystem_Refresh(self.__identify, function(argList)
    if argList ~= nil and argList.Count > 0 then
      local storeSystemData = argList[0]
      self.__storeSystemData = storeSystemData
      self:__DealStoreData()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessStoreCtrl:WCExchangeItem(itemId, callback)
  local costItemID = self:GetExChangeItemID(itemId)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_StoreSystem_ExchangeItem(self.__identify, costItemID, function(argList)
    if argList ~= nil and argList.Count > 0 then
      local costItemID = argList[0]
      local leftNumDic = self.__storeSystemData.buyItemNum
      if costItemID == ConstGlobalItem.WCMoney then
        local coin2rare = ConstGlobalItem.WCMoney << 32 | ConstGlobalItem.WCDeployPoint
        leftNumDic[coin2rare] = (leftNumDic[coin2rare] or 0) - 1
      elseif costItemID == ConstGlobalItem.WCDeployPoint then
        local rare2coin = ConstGlobalItem.WCDeployPoint << 32 | ConstGlobalItem.WCMoney
        leftNumDic[rare2coin] = (leftNumDic[rare2coin] or 0) - 1
      end
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessStoreCtrl:WCBuyBuff(storeData, callback)
  local idx = storeData.idx - 1
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_StoreSystem_SelectBuff(self.__identify, idx, function()
    storeData.saled = true
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessStoreCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  UIManager:DeleteWindow(UIWindowTypeID.WarChessStore)
  self.__storeSystemData = nil
  self.__identify = nil
  self.__storeChipDataList = nil
  self.__storeBuffDataList = nil
end

function WarChessStoreCtrl:ExitWCStore(callback)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_StoreSystem_Quit(self.__identify, function()
    if callback ~= nil then
      callback()
    end
  end)
  self.__storeSystemData = nil
  self.__identify = nil
  self.__storeChipDataList = nil
  self.__storeBuffDataList = nil
end

function WarChessStoreCtrl:Delete()
end

return WarChessStoreCtrl
