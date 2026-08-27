local base = UIBaseWindow
local UIWarChessDiscard = class("UIWarChessDiscard", base)
local UINWarChessDiscardChipItem = require("Game.WarChess.UI.Discard.UINWarChessDiscardChipItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")

function UIWarChessDiscard:OnInit()
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.__OnClickShowMap)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClicWCSkLeave)
  UIUtil.AddButtonListener(self.ui.btn_AddTotalCount, self, self.OnClickWCAddChipCapacity)
  self.chipItemDic = {}
  self.chipList = nil
  self.ui.chipLoopList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.chipLoopList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.uINChipItemDetail)
  self.chipDetailPanel:Hide()
  self.ui.obj_img_DetailEmpty:SetActive(true)
  self.__onClickWCSChipItem = BindCallback(self, self.OnSelectWCSChipItem)
  self.__onChipChange = BindCallback(self, self.__OnChipChange)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onChipChange)
  self.__onChipCapacityChange = BindCallback(self, self.__OnChipCapacityChange)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self.__onChipCapacityChange)
end

function UIWarChessDiscard:InitWCChipDiscard(discardCtrl, teamData)
  self.discardCtrl = discardCtrl
  self._teamData = teamData
  self:RefreshWCDiscardTeamInfo()
  self:RefreshAllChips()
  self:RefreshAddLimit()
  self.ui.tex_MapBtnName:SetIndex(0)
end

function UIWarChessDiscard:RefreshWCDiscardTeamInfo()
  local dynPlayer = self._teamData:GetTeamDynPlayer()
  local _, curChipCount, maxChipCount = dynPlayer:IsChipOverLimitNum()
  self.ui.tex_GroupTitle.text = string.format("%s(%s/%s)", self._teamData:GetWCTeamName(), tostring(curChipCount), tostring(maxChipCount))
  self:__RefreshExitSituation(curChipCount, maxChipCount)
end

function UIWarChessDiscard:__RefreshExitSituation(curChipCount, maxChipCount)
  local isFoceDiscard = maxChipCount < curChipCount
  self.ui.needDiscard:SetActive(isFoceDiscard)
  if isFoceDiscard then
    self.ui.tex_NeedDiscard:SetIndex(0, tostring(curChipCount - maxChipCount))
  end
end

function UIWarChessDiscard:RefreshAddLimit()
  local costItemId, costItemNum = self.discardCtrl:GetWCCapacityUpGradeCost(self._teamData)
  self.ui.tex_Money.text = tostring(costItemNum)
  self.ui.img_Money.sprite = CRH:GetSpriteByItemId(costItemId)
end

function UIWarChessDiscard:RefreshAllChips()
  self.chipList = self._teamData:GetWCTeamChipList()
  local num = #self.chipList
  self.ui.chipLoopList.totalCount = num
  self.ui.chipLoopList:RefillCells()
end

function UIWarChessDiscard:m_OnNewItem(go)
  local ChipDiscardItem = UINWarChessDiscardChipItem.New()
  ChipDiscardItem:Init(go)
  self.chipItemDic[go] = ChipDiscardItem
end

function UIWarChessDiscard:m_OnChangeItem(go, index)
  local ChipDiscardItem = self.chipItemDic[go]
  if ChipDiscardItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local chipData = self.chipList[index + 1]
  if chipData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
  end
  local discardPrice, MoneyIconId = self.discardCtrl:GetWCChipDiscardPrice(chipData)
  ChipDiscardItem:InitWCDiscardChipItem(chipData, discardPrice, MoneyIconId, self.__onClickWCSChipItem)
  ChipDiscardItem:SetStoreItemSelect(self.selectedData == chipData)
  if self.selectedData == nil and index == 0 then
    self:OnSelectWCSChipItem(ChipDiscardItem)
  end
end

function UIWarChessDiscard:m_GetItemByData(chipData)
  for k, v in ipairs(self.chipList) do
    if v == chipData then
      local index = k - 1
      return self:m_GetItemGoByIndex(index)
    end
  end
end

function UIWarChessDiscard:m_GetItemGoByIndex(index)
  local go = self.ui.chipLoopList:GetCellByIndex(index)
  if go ~= nil then
    local ChipDiscardItem = self.chipItemDic[go]
    return ChipDiscardItem
  end
  return nil
end

function UIWarChessDiscard:OnSelectWCSChipItem(chipItem)
  if self.selectedData ~= nil and self.selectedData ~= chipItem.chipData then
    local lastItem = self:m_GetItemByData(self.selectedData)
    if lastItem ~= nil then
      lastItem:SetStoreItemSelect(false)
    end
  end
  self.selectedData = chipItem.chipData
  local index = table.indexof(self.chipList, self.selectedData)
  chipItem:SetStoreItemSelect(true)
  local salePrice = self.discardCtrl:GetWCChipDiscardPrice(self.selectedData)
  local dynPlayer = self._teamData:GetTeamDynPlayer()
  self.chipDetailPanel:InitEpChipDetail(index, self.selectedData, dynPlayer, self.resloader, true, eChipDetailPowerType.Subtract, true)
  self.chipDetailPanel:ShowEpChipDetailEff(5)
  self.chipDetailPanel:SetObjNewTagActive(false)
  self.chipDetailPanel:GetDetailButtonGroup():InitBtnSelByCost(false, salePrice, function()
    local algId = chipItem.chipData.dataId
    self.discardCtrl:WCDiscardChip(algId, function()
      if isGameDev then
        print("丢弃结束")
      end
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8533))
    end)
  end)
  self.chipDetailPanel:Show()
  self.ui.obj_img_DetailEmpty:SetActive(false)
end

function UIWarChessDiscard:OnClickWCAddChipCapacity()
  self.discardCtrl:AddWCChipCapacity(nil)
end

function UIWarChessDiscard:OnClicWCSkLeave()
  self.discardCtrl:ExitWCDiscard(function()
    self:Delete()
  end)
end

function UIWarChessDiscard:__OnClickShowMap()
  local isOpen = self.ui.frameNode.activeInHierarchy
  self.ui.tex_MapBtnName:SetIndex(isOpen and 1 or 0)
  self.ui.frameNode:SetActive(not isOpen)
end

function UIWarChessDiscard:__OnChipChange()
  self.selectedData = nil
  self.chipDetailPanel:Hide()
  self.ui.obj_img_DetailEmpty:SetActive(true)
  self:RefreshWCDiscardTeamInfo()
  self:RefreshAllChips()
end

function UIWarChessDiscard:__OnChipCapacityChange()
  self:RefreshAddLimit()
  self:RefreshWCDiscardTeamInfo()
end

function UIWarChessDiscard:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onChipChange)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self.__onChipCapacityChange)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIWarChessDiscard
