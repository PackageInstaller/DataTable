local UINWarChessBuyList = class("UINWarChessBuyList", UIBaseNode)
local base = UIBaseNode
local UINWarChessStoreChipItem = require("Game.WarChess.UI.Store.UINWarChessStoreChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINWarChessBuyList:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINWarChessBuyList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chipItemPool = UIItemPool.New(UINWarChessStoreChipItem, self.ui.storeChipItem)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self.__onWCChipChanged = BindCallback(self, self.OnDynPlayChipUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
end

function UINWarChessBuyList:InitWarchessStoreRoomBuyList(storeItemDataList)
  if 20 < #storeItemDataList then
    error("The num(chip) greater than 20.")
    return
  end
  self.itemIndexDic = {}
  local chipNum = 0
  local sortedStoreItemDataList = {}
  for k, v in ipairs(storeItemDataList) do
    table.insert(sortedStoreItemDataList, v)
    if v.chipData ~= nil then
      chipNum = chipNum + 1
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
  self.selectIndex = nil
  for k, storeItemData in ipairs(sortedStoreItemDataList) do
    if not storeItemData.saled then
      self.selectIndex = storeItemData.idx
      break
    end
  end
  if self.selectIndex == nil then
    self.selectIndex = 1
  end
  local hasChip = 0 < chipNum
  self.ui.groupItem_Chip:SetActive(hasChip)
  self.chipItemPool:HideAll()
  local buyPrice
  for k, storeItemData in ipairs(sortedStoreItemDataList) do
    local isSelected = storeItemData.idx == self.selectIndex
    if storeItemData.chipData ~= nil then
      local chipItem = self.chipItemPool:GetOne()
      chipItem.transform:SetParent(self.ui.groupItem_Chip.transform)
      chipItem.transform:SetAsLastSibling()
      chipItem:InitWCStoreChipItem(storeItemData, self.storeRoomRoot.CoinIconId, self._OnClickChipItemFunc, false)
      chipItem:SetStoreItemSelect(isSelected)
      if isSelected then
        buyPrice = chipItem.price
      end
      local isHadChip = false
      local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
      chipItem:SetNewTagActive(false, chipShowState)
      self.itemIndexDic[storeItemData.idx] = chipItem
    end
  end
  self.selectBuyPrice = buyPrice
end

function UINWarChessBuyList:OnDynPlayChipUpdate(chipList, dynPlayer)
end

function UINWarChessBuyList:_OnClickChipItem(chipItem)
  local index = chipItem.epStoreItemData.idx
  self.selectIndex = index
  self.selectBuyPrice = chipItem.price
  self.storeRoomRoot:OnSelectWCSChipItemForBuy(chipItem)
end

function UINWarChessBuyList:GetChipItemByIndex(index)
  return self.itemIndexDic[index]
end

function UINWarChessBuyList:RefreshAllItemSellOut()
  for k, v in pairs(self.itemIndexDic) do
    v:WCRefreshShowSaledType(v.epStoreItemData.saled)
  end
end

function UINWarChessBuyList:GetEpStoreBuyData()
  local selectItem = self.itemIndexDic[self.selectIndex]
  return self.selectIndex, self.selectBuyPrice, selectItem
end

function UINWarChessBuyList:OnShow()
  base.OnShow(self)
  local scrollBar = self.ui.scrollRect.verticalScrollbar
  if not IsNull(scrollBar) then
    scrollBar.gameObject:SetActive(true)
  end
  self.ui.otherScrollbar:SetActive(false)
end

function UINWarChessBuyList:OnHide()
  base.OnHide()
  local scrollBar = self.ui.scrollRect.verticalScrollbar
  if not IsNull(scrollBar) then
    scrollBar.gameObject:SetActive(false)
  end
  self.ui.otherScrollbar:SetActive(true)
end

function UINWarChessBuyList:OnDelete()
  self.chipItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  base.OnDelete(self)
end

return UINWarChessBuyList
