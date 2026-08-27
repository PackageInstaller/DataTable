local UINEpStoreRoomSellList = class("UINEpStoreRoomSellList", UIBaseNode)
local base = UIBaseNode
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")

function UINEpStoreRoomSellList:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINEpStoreRoomSellList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self.ui.storeList.onInstantiateItem = BindCallback(self, self.__StoreListInitItem)
  self.ui.storeList.onChangeItem = BindCallback(self, self.__ChipListItemChanged)
  self.storeItemDic = {}
  self:SetSellListEmptyUI(false)
end

function UINEpStoreRoomSellList:InitEpStoreRoomSell(chipList)
  self.chipList = chipList
  self:SetSellListEmptyUI(#self.chipList <= 0)
  if #self.chipList > 0 then
    self.chipList = ExplorationManager:SortChipDataList(self.chipList, true)
  end
  self.selectedIndex = 1
  self.storeRoomRoot:RefreshSelectItemDetailSoldOut(self.selectedIndex)
  self.ui.storeList.totalCount = #chipList
  self.ui.storeList:RefillCells()
end

function UINEpStoreRoomSellList:__StoreListInitItem(go)
  local storeItem = UIEpStoreRoomItem.New()
  storeItem:Init(go)
  self.storeItemDic[go] = storeItem
end

function UINEpStoreRoomSellList:__ChipListItemChanged(go, index)
  local storeItem = self.storeItemDic[go]
  if storeItem == nil then
    error("Can't find Item by gameObject")
    return
  end
  index = index + 1
  local chipData = self.chipList[index]
  chipData.idx = index
  if chipData == nil then
    error("Can't find chipData by index, index = " .. tonumber(index))
  end
  storeItem:InitStoreRoomItem(self.storeRoomRoot.roomId, chipData, self.storeRoomRoot.MoneyIconId, self._OnClickChipItemFunc, true, self.storeRoomRoot.storeCtrl.dynPlayer)
  storeItem:SetStoreItemSelect(index == self.selectedIndex)
end

function UINEpStoreRoomSellList:GetEpStoreRoomSellByIndex(index)
  local go = self.ui.storeList:GetCellByIndex(index - 1)
  if not IsNull(go) then
    local storeItem = self.storeItemDic[go]
    return storeItem
  end
  return nil
end

function UINEpStoreRoomSellList:GetCurEpStoreRoomSell()
  return self:GetEpStoreRoomSellByIndex(self.selectedIndex)
end

function UINEpStoreRoomSellList:_OnClickChipItem(chipItem)
  if self.selectedIndex == chipItem.index then
    return
  end
  self.selectedIndex = chipItem.index
  self.storeRoomRoot:OnSelectStoreChipItem(chipItem)
end

function UINEpStoreRoomSellList:SetSellListEmptyUI(active)
  for k, v in ipairs(self.ui.emptys) do
    v:SetActive(active)
  end
end

function UINEpStoreRoomSellList:OnDelete()
  base.OnDelete(self)
end

return UINEpStoreRoomSellList
