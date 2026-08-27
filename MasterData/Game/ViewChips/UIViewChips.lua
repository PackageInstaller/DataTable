local UIViewChips = class("UIViewChips", UIBaseWindow)
local base = UIBaseWindow
local UIViewChipsItem = require("Game.ViewChips.UIViewChipsItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINBaseChipDetail")
local ChipData = require("Game.PlayerData.Item.ChipData")

function UIViewChips:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.mask_Close, self, self.__OnClickClose)
  self.ui.obj_chipItem:SetActive(false)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.chipItemDetail)
  self.ui.chipList.onInstantiateItem = BindCallback(self, self.__LevelChipListInitItem)
  self.ui.chipList.onChangeItem = BindCallback(self, self.__LevelChipListItemChanged)
  self.__onLevelItemClick = BindCallback(self, self.__OnLevelItemClick)
  self.__OnChipSetUpdate = BindCallback(self, self.OnChipSetUpdate)
  self.levelChipItemDic = {}
  self.chipSetTab = {}
end

function UIViewChips:InitLevelChip(sectorStageCfg, resloader)
  self.resloader = resloader
  self.selectedIndex = 1
  self.networkContrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.networkContrl:SendChipSet()
  local chip_dic = {}
  for k, v in pairs(sectorStageCfg.function_extra) do
    chip_dic[v] = true
  end
  local chip_pool_dic = {}
  for _, epId in pairs(sectorStageCfg.exploration_list) do
    local epCfg = ConfigData.exploration[epId]
    if epCfg ~= nil then
      for _, poolId in pairs(epCfg.chip_pool) do
        chip_pool_dic[poolId] = true
        local funcPoolCfg = ConfigData.ep_function_pool[poolId]
        if funcPoolCfg ~= nil then
          for _, chipId in pairs(funcPoolCfg.function_pool) do
            chip_dic[chipId] = true
          end
        end
      end
    end
  end
  self.chipDataList = {}
  local chipData
  for itemId, _ in pairs(chip_dic) do
    chipData = ChipData.NewChipForLocal(itemId)
    chipData.isLock = false
    table.insert(self.chipDataList, chipData)
  end
  self.ui.chipList.totalCount = #self.chipDataList
  self:__ChipListUpdateInternal()
end

function UIViewChips:InitChips(chipDataList, resloader, needShowLock)
  self.resloader = resloader
  self.selectedIndex = 1
  self.needShowLock = needShowLock or false
  self.chipDataList = {}
  for index, value in ipairs(chipDataList) do
    table.insert(self.chipDataList, value)
  end
  self.ui.chipList.totalCount = #self.chipDataList
  self:__ChipListUpdateInternal()
end

function UIViewChips:OnChipSetUpdate(chipSetTab)
  self:__ChipListUpdateInternal()
end

function UIViewChips:__ChipListUpdateInternal()
  self:__SortList()
  self.ui.chipList:RefillCells()
end

function UIViewChips:__SortList()
  if #self.chipDataList > 0 then
    self.chipDataList = ExplorationManager:SortChipDataList(self.chipDataList)
  end
  self.ui.chipList:RefillCells()
end

function UIViewChips:__LevelChipListInitItem(go)
  local levelChipItem = UIViewChipsItem.New()
  levelChipItem:Init(go)
  self.levelChipItemDic[go] = levelChipItem
end

function UIViewChips:__LevelChipListItemChanged(go, index)
  local levelChipItem = self.levelChipItemDic[go]
  if levelChipItem == nil then
    error("Can't find levelChipItem by gameObject")
    return
  end
  index = index + 1
  local ChipData = self.chipDataList[index]
  if ChipData == nil then
    error("Can't find ChipData by index:" .. tonumber(index))
  end
  if self.needShowLock then
    levelChipItem:InitLevelChipItem(index, ChipData, ChipData.isLock)
  else
    levelChipItem:InitLevelChipItem(index, ChipData, true)
  end
  levelChipItem:SetLevelChipItemSelect(index == self.selectedIndex)
  levelChipItem:SetClickEvent(self.__onLevelItemClick)
  self:RefreshSelectItemDetail()
end

function UIViewChips:__OnLevelItemClick(levelChipItem)
  if levelChipItem == nil then
    return
  end
  if self.selectedIndex == levelChipItem:GetIndex() then
    return
  end
  local lastStoreItem = self:__GetItemByIndex(self.selectedIndex)
  if lastStoreItem ~= nil then
    lastStoreItem:SetLevelChipItemSelect(false)
  end
  self.selectedIndex = levelChipItem:GetIndex()
  levelChipItem:SetLevelChipItemSelect(true)
  self:RefreshSelectItemDetail()
end

function UIViewChips:RefreshSelectItemDetail()
  local chipData = self.chipDataList[self.selectedIndex]
  if chipData == nil then
    self.chipDetailPanel:Hide()
    return
  end
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitBaseChipDetail(self.selectedIndex, chipData, nil, self.resloader, nil)
end

function UIViewChips:__GetItemByIndex(index)
  local go = self.ui.chipList:GetCellByIndex(index - 1)
  if not IsNull(go) then
    local storeItem = self.levelChipItemDic[go]
    return storeItem
  end
  return nil
end

function UIViewChips:SetViewChipsCloseCallback(action)
  self._onViewChipsClose = action
end

function UIViewChips:BackAction()
  if self._onViewChipsClose ~= nil then
    self._onViewChipsClose()
  end
  self:Delete()
end

function UIViewChips:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIViewChips:OnShow()
  base.OnShow(self)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
end

function UIViewChips:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  base.OnShow(self)
end

function UIViewChips:OnDelete()
  self.chipDetailPanel:Delete()
  self._onViewChipsClose = nil
  base.OnDelete(self)
end

return UIViewChips
