local UINEpOverclockChipSelect = class("UINEpOverclockChipSelect", UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local UINEpOverclockChipItem = require("Game.Exploration.UI.Overclock.UINEpOverclockChipItem")

function UINEpOverclockChipSelect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._onClickConfirm = BindCallback(self, self.OnClickConfirm)
  self.ui.obj_sortLabelItem:SetActive(false)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.uINChipItemDetail)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(false)
  self.ui.chipList.onInstantiateItem = BindCallback(self, self.__OnListInstantiateItem)
  self.ui.chipList.onChangeItem = BindCallback(self, self.__OnChipListChangedItem)
  self.__onChipItemClick = BindCallback(self, self.__OnChipItemClick)
  self.chipItemDic = {}
  self:Hide()
end

function UINEpOverclockChipSelect:InitClockChipSelectNode(dynplayer, chipDic, resLoader, selectComplete)
  self:Show()
  self.__selectComplete = selectComplete
  self.__dynPlayer = dynplayer
  self.resLoader = resLoader
  self.selectedIndex = 1
  self._getChipDic = self.__dynPlayer:GetNormalChipDic()
  self:__InitChipsData(chipDic)
  self:RefreshClockSelectItemDetail()
end

function UINEpOverclockChipSelect:__InitChipsData(chipDic)
  self.__chipDataList = self:__SortChipList(chipDic)
  self.ui.chipList.totalCount = #self.__chipDataList
  self.ui.chipList:RefillCells()
end

function UINEpOverclockChipSelect:__SortChipList(chipDic)
  local tab = {}
  for chipId, _ in pairs(chipDic) do
    local chipData = ChipData.NewChipForLocal(chipId)
    table.insert(tab, chipData)
  end
  if 0 < #tab then
    tab = ExplorationManager:SortChipDataList(tab)
  end
  return tab
end

function UINEpOverclockChipSelect:__OnListInstantiateItem(go)
  local chipItem = UINEpOverclockChipItem.New()
  chipItem:Init(go)
  self.chipItemDic[go] = chipItem
end

function UINEpOverclockChipSelect:__OnChipListChangedItem(go, index)
  local chipItem = self.chipItemDic[go]
  if chipItem == nil then
    error("Can't find chipItem by gameObject")
    return
  end
  index = index + 1
  local chipData = self.__chipDataList[index]
  if chipData == nil then
    error("Can't find chipData by index:" .. tonumber(index))
  end
  chipItem:InitOverclockChipItem(index, chipData, self.__onChipItemClick)
  chipItem:SetSelectUI(index == self.selectedIndex)
  local has = self._getChipDic[chipData.dataId]
  chipItem:SetHasUI(has ~= nil)
  if self.__dynPlayer ~= nil then
    chipItem.chipItem:UpdateChipItem(self.__dynPlayer)
  end
end

function UINEpOverclockChipSelect:__OnChipItemClick(chipItem)
  if chipItem == nil then
    return
  end
  if self.selectedIndex == chipItem.index then
    return
  end
  local lastItem = self:__GetItemByIndex(self.selectedIndex)
  if lastItem ~= nil then
    lastItem:SetSelectUI(false)
  end
  self.selectedIndex = chipItem.index
  chipItem:SetSelectUI(true)
  chipItem.chipItem:RefreshLevelTween()
  self:RefreshClockSelectItemDetail()
end

function UINEpOverclockChipSelect:RefreshClockSelectItemDetail()
  local index = self.selectedIndex or 1
  local chipData = self.__chipDataList[index]
  if chipData == nil then
    self.chipDetailPanel:Hide()
    return
  end
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitEpChipDetail(self.selectedIndex, chipData, self.__dynPlayer, self.resLoader)
  self.chipDetailPanel:ShowEpChipDetailEff()
  self.chipDetailPanel:GetDetailButtonGroup():InitBtnSelect(self._onClickConfirm)
end

function UINEpOverclockChipSelect:__GetItemByIndex(index)
  local go = self.ui.chipList:GetCellByIndex(index - 1)
  if not IsNull(go) then
    local storeItem = self.chipItemDic[go]
    return storeItem
  end
  return nil
end

function UINEpOverclockChipSelect:OnClickConfirm()
  local chipData = self.__chipDataList[self.selectedIndex]
  if chipData == nil then
    return
  end
  self:Hide()
  if self.__selectComplete ~= nil then
    self.__selectComplete(chipData)
    self.__selectComplete = nil
  end
end

function UINEpOverclockChipSelect:OnDelete()
  self.chipDetailPanel:OnDelete()
  base.OnDelete(self)
end

return UINEpOverclockChipSelect
