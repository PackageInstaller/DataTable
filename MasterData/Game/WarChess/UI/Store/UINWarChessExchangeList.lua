local UINWarChessExchangeList = class("UINWarChessExchangeList", UIBaseNode)
local base = UIBaseNode
local UINWarChessCoinItem = require("Game.WarChess.UI.Store.UINWarChessCoinItem")
local UINWarChessBuffItem = require("Game.WarChess.UI.Store.UINWarChessBuffItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINWarChessExchangeList:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINWarChessExchangeList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.storeBuffItem:SetActive(false)
  self.buffItemPool = UIItemPool.New(UINWarChessBuffItem, self.ui.storeBuffItem)
  self.ui.storeCoinItem:SetActive(false)
  self.coinItemPool = UIItemPool.New(UINWarChessCoinItem, self.ui.storeCoinItem)
  self._OnClickBuffItemFunc = BindCallback(self, self.OnClickBuffItem)
  self._OnClickCoinItemFunc = BindCallback(self, self.OnClickCoinItem)
  self.__onWCChipChanged = BindCallback(self, self.OnDynPlayChipUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
end

function UINWarChessExchangeList:InitExchangeList(storeItemDataList)
  self:InitCointList()
  if 20 < #storeItemDataList then
    error("The num(buff) greater than 20.")
    return
  end
  self.itemIndexDic = {}
  local buffNum = 0
  local sortedStoreItemDataList = {}
  for k, v in ipairs(storeItemDataList) do
    table.insert(sortedStoreItemDataList, v)
    if v.epBuffData ~= nil then
      buffNum = buffNum + 1
    end
  end
  table.sort(sortedStoreItemDataList, function(a, b)
    local aChip = a.chipData ~= nil
    local bChip = b.chipData ~= nil
    if aChip ~= bChip then
      return aChip
    end
    return a.idx < b.idx
  end)
  self.selectIndex = -1
  local hasBuff = 0 < buffNum
  self.ui.groupItem_Buff:SetActive(hasBuff)
  self.buffItemPool:HideAll()
  for k, storeItemData in ipairs(sortedStoreItemDataList) do
    if storeItemData.epBuffData ~= nil then
      local buffItem = self.buffItemPool:GetOne()
      buffItem.transform:SetParent(self.ui.groupItem_Buff.transform)
      buffItem.transform:SetAsLastSibling()
      buffItem:SetStoreBuffItemSelect(false)
      buffItem:InitWarchessStoreBuffItem(storeItemData, self.storeRoomRoot.RareIconId, self._OnClickBuffItemFunc)
      self.itemIndexDic[storeItemData.idx] = buffItem
    end
  end
end

function UINWarChessExchangeList:InitCointList()
  self.coinItemPool:HideAll()
  local shopId = WarChessManager:GetWCLevelShopId()
  local shopCointCfg = ConfigData.warchess_shop_coin[shopId]
  local shopRareCfg = ConfigData.warchess_shop_rare[shopId]
  if shopCointCfg == nil or shopRareCfg == nil then
    return
  end
  local coinCfg = ConfigData.item[shopCointCfg.item1]
  local rareCfg = ConfigData.item[shopRareCfg.item2]
  if coinCfg ~= nil and rareCfg ~= nil then
    local coinItem = self.coinItemPool:GetOne()
    coinItem.transform:SetParent(self.ui.groupItem_Coin.transform)
    coinItem.transform:SetAsLastSibling()
    local rareItem = self.coinItemPool:GetOne()
    rareItem.transform:SetParent(self.ui.groupItem_Coin.transform)
    rareItem.transform:SetAsLastSibling()
    local refreshCount = self.storeRoomRoot.storeCtrl:GetRefreshTime()
    local getCoinPrice = shopRareCfg.buy_coin - shopRareCfg.buy_coin_decrease * refreshCount
    local needCoinPrice = shopCointCfg.buy_rare + shopCointCfg.buy_rare_increase * refreshCount
    local isExchangeCoin = self.storeRoomRoot.storeCtrl:GetCoinExchangeIsUse()
    local isExchangeRare = self.storeRoomRoot.storeCtrl:GetRareExchangeIsUse()
    coinItem:InitWarchessStoreCoinItem(coinCfg, rareCfg.icon, 1, getCoinPrice, self._OnClickCoinItemFunc)
    coinItem:UpdateSellOutActive(isExchangeCoin)
    rareItem:InitWarchessStoreCoinItem(rareCfg, coinCfg.icon, needCoinPrice, 1, self._OnClickCoinItemFunc)
    rareItem:UpdateSellOutActive(isExchangeRare)
    self:OnClickCoinItem(coinItem)
  end
end

function UINWarChessExchangeList:OnDynPlayChipUpdate(chipList, dynPlayer)
end

function UINWarChessExchangeList:OnClickBuffItem(buffItem)
  self.curCoinItem = nil
  local index = buffItem.epStoreItemData.idx
  if self.selectIndex == index then
    return
  end
  self.selectIndex = index
  self.selectBuyPrice = buffItem.price
  self.storeRoomRoot:OnSelectStoreBuffItem(buffItem)
end

function UINWarChessExchangeList:OnClickCoinItem(cointItem)
  self.curCoinItem = cointItem
  self.selectIndex = -1
  self.storeRoomRoot:OnSelectStoreCoinItem(cointItem)
end

function UINWarChessExchangeList:GetEpStoreBuyData()
  local selectItem = self.itemIndexDic[self.selectIndex]
  return self.selectIndex, self.selectBuyPrice, selectItem
end

function UINWarChessExchangeList:GetCurCoinItem()
  return self.curCoinItem
end

function UINWarChessExchangeList:OnShow()
  base.OnShow(self)
  local scrollBar = self.ui.scrollRect.verticalScrollbar
  if not IsNull(scrollBar) then
    scrollBar.gameObject:SetActive(true)
  end
end

function UINWarChessExchangeList:OnHide()
  base.OnHide()
  local scrollBar = self.ui.scrollRect.verticalScrollbar
  if not IsNull(scrollBar) then
    scrollBar.gameObject:SetActive(false)
  end
end

function UINWarChessExchangeList:OnDelete()
  self.buffItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  base.OnDelete(self)
end

return UINWarChessExchangeList
