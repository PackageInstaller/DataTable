local UINEpStoreRoomBuyList = class("UINEpStoreRoomBuyList", UIBaseNode)
local base = UIBaseNode
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
local UINEpStoreBuffItem = require("Game.Exploration.UI.StoreRoom.UINEpStoreBuffItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINEpStoreRoomBuyList:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINEpStoreRoomBuyList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chipItemPool = UIItemPool.New(UIEpStoreRoomItem, self.ui.storeChipItem)
  self.ui.storeBuffItem:SetActive(false)
  self.buffItemPool = UIItemPool.New(UINEpStoreBuffItem, self.ui.storeBuffItem)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self._OnClickBuffItemFunc = BindCallback(self, self._OnClickBuffItem)
end

function UINEpStoreRoomBuyList:InitEpStoreRoomBuyList(storeItemDataList)
  if 20 < #storeItemDataList then
    error("The num(chip + buff) greater than 20.")
    return
  end
  self.itemIndexDic = {}
  local chipNum = 0
  local buffNum = 0
  local sortedStoreItemDataList = {}
  for k, v in ipairs(storeItemDataList) do
    table.insert(sortedStoreItemDataList, v)
    if v.chipData ~= nil then
      chipNum = chipNum + 1
    elseif v.epBuffData ~= nil then
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
  local hasBuff = 0 < buffNum
  self.ui.groupItem_Buff:SetActive(hasBuff)
  self.chipItemPool:HideAll()
  self.buffItemPool:HideAll()
  local buyPrice
  for k, storeItemData in ipairs(sortedStoreItemDataList) do
    local isSelected = storeItemData.idx == self.selectIndex
    if storeItemData.chipData ~= nil then
      local chipItem = self.chipItemPool:GetOne()
      chipItem.transform:SetParent(self.ui.groupItem_Chip.transform)
      chipItem.transform:SetAsLastSibling()
      chipItem:InitStoreRoomItem(self.storeRoomRoot.roomId, storeItemData, self.storeRoomRoot.MoneyIconId, self._OnClickChipItemFunc, nil, self.storeRoomRoot.storeCtrl.dynPlayer)
      chipItem:SetStoreItemSelect(isSelected)
      if isSelected then
        buyPrice = chipItem.price
      end
      local isHadChip = self.storeRoomRoot.storeCtrl.dynPlayer.chipDic[storeItemData.chipData.dataId] ~= nil
      local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
      chipItem:SetNewTagActive(true, chipShowState)
      self.itemIndexDic[storeItemData.idx] = chipItem
    elseif storeItemData.epBuffData ~= nil then
      local buffItem = self.buffItemPool:GetOne()
      buffItem.transform:SetAsLastSibling()
      buffItem:SetStoreBuffItemSelect(isSelected)
      buffItem:InitEpStoreBuffItem(storeItemData, self.storeRoomRoot.MoneyIconId, self._OnClickBuffItemFunc)
      if isSelected then
        buyPrice = buffItem.price
      end
      self.itemIndexDic[storeItemData.idx] = buffItem
    end
  end
  self.storeRoomRoot:RefreshBuySelectItemDetail(self.selectIndex, buyPrice)
  self.selectBuyPrice = buyPrice
end

function UINEpStoreRoomBuyList:_OnClickChipItem(chipItem)
  local index = chipItem.epStoreItemData.idx
  if self.selectIndex == index then
    return
  end
  self.selectIndex = index
  self.selectBuyPrice = chipItem.price
  self.storeRoomRoot:OnSelectStoreChipItem(chipItem)
end

function UINEpStoreRoomBuyList:_OnClickBuffItem(buffItem)
  local index = buffItem.epStoreItemData.idx
  if self.selectIndex == index then
    return
  end
  self.selectIndex = index
  self.selectBuyPrice = buffItem.price
  self.storeRoomRoot:OnSelectStoreBuffItem(buffItem)
end

function UINEpStoreRoomBuyList:GetEpStoreBuyData()
  local selectItem = self.itemIndexDic[self.selectIndex]
  return self.selectIndex, self.selectBuyPrice, selectItem
end

function UINEpStoreRoomBuyList:OnShow()
  base.OnShow(self)
  local scrollBar = self.ui.scrollRect.verticalScrollbar
  if not IsNull(scrollBar) then
    scrollBar.gameObject:SetActive(true)
  end
end

function UINEpStoreRoomBuyList:OnHide()
  base.OnHide()
  local scrollBar = self.ui.scrollRect.verticalScrollbar
  if not IsNull(scrollBar) then
    scrollBar.gameObject:SetActive(false)
  end
end

function UINEpStoreRoomBuyList:OnDelete()
  self.chipItemPool:DeleteAll()
  self.buffItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINEpStoreRoomBuyList
