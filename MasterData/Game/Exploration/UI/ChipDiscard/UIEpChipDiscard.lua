local UIEpChipDiscard = class("UIEpChipDiscard", UIBaseWindow)
local base = UIBaseWindow
local UINEpChipDiscardItem = require("Game.Exploration.UI.ChipDiscard.UINEpChipDiscardItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon

function UIEpChipDiscard:OnInit()
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.chipItemDic = {}
  self.chipDataList = {}
  self.isOverLimit = true
  self.costItemNum = 0
  self.costItemId = ConstGlobalItem.EpMoney
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnStoreMapClicked)
  self._onDiscardChip = BindCallback(self, self.DiscardChip)
  UIUtil.AddButtonListener(self.ui.btn_AddTotalCount, self, self.AddChipLimit)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.CloseEpDiscard)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.__onChipListChange = BindCallback(self, self.OnChipListChange, false)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  self.__OnChipLimitChange = BindCallback(self, self.OnChipLimitChange)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self.__OnChipLimitChange)
  self._OnClick = BindCallback(self, self.OnClick)
  self.ui.chipLoopList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.chipLoopList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.uINChipItemDetail)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
end

function UIEpChipDiscard:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
  self.transform:SetAsFirstSibling()
end

function UIEpChipDiscard:OnHide()
  base.OnHide(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

function UIEpChipDiscard:InitEpChipDiscard(dynPlayer, closeCallback, needConsumeSkill)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self.dynPlayer = dynPlayer
  self.closeCallback = closeCallback
  self._needConsumeSkill = needConsumeSkill
  self.discardId = self.dynPlayer:GetChipDiscardId()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  self.position = opDetail.curPostion
  self:OnChipListChange(true)
  self.__mapActiveState = false
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

function UIEpChipDiscard:RegisterWinCallbacks(discardCb, closeCb, setUICb)
  self._regOnDiscardCallback = discardCb
  self._regOnCloseCallback = closeCb
  if setUICb ~= nil then
    setUICb(self)
  end
end

function UIEpChipDiscard:OnChipListChange(isFirstOpen)
  self:RefreshExitSituation()
  self:RefreshAddLimit()
  self:RefreshLoopList()
  MsgCenter:Broadcast(eMsgEventId.OnChipDiscardChanged, isFirstOpen)
end

function UIEpChipDiscard:OnChipLimitChange()
  self:RefreshExitSituation()
  self:RefreshAddLimit()
  MsgCenter:Broadcast(eMsgEventId.OnChipDiscardChanged, false)
end

function UIEpChipDiscard:RefreshExitSituation()
  local nowCount, nowLimit
  self.isOverLimit, nowCount, nowLimit = self.dynPlayer:IsChipOverLimitNum()
  self.ui.needDiscard:SetActive(self.isOverLimit)
  if self.isOverLimit then
    local needDrop = nowCount - nowLimit
    self.ui.tex_NeedDiscard:SetIndex(0, tostring(needDrop))
  end
end

function UIEpChipDiscard:RefreshLoopList()
  self.chipDataList = {}
  for chipId, chipData in pairs(self.dynPlayer:GetNormalChipDic()) do
    if self._needConsumeSkill or not chipData:IsConsumeSkillChip() then
      table.insert(self.chipDataList, chipData)
    end
  end
  local num = #self.chipDataList
  if 0 < num then
    self.chipDetailPanel:Show()
  else
    self.chipDetailPanel:Hide()
  end
  if #self.chipDataList > 0 then
    self.chipDataList = ExplorationManager:SortChipDataList(self.chipDataList, true)
  end
  self.ui.chipLoopList.totalCount = num
  self.ui.chipLoopList:RefillCells()
end

function UIEpChipDiscard:RefreshAddLimit()
  self.costItemId, self.costItemNum = self.dynPlayer:GetChipUpgradeLimitPrice()
  self.ui.tex_Money.text = tostring(self.costItemNum)
  self.ui.img_Money.sprite = CRH:GetSpriteByItemId(self.costItemId)
end

function UIEpChipDiscard:m_OnNewItem(go)
  local ChipDiscardItem = UINEpChipDiscardItem.New()
  ChipDiscardItem:Init(go)
  self.chipItemDic[go] = ChipDiscardItem
end

function UIEpChipDiscard:m_OnChangeItem(go, index)
  local ChipDiscardItem = self.chipItemDic[go]
  if ChipDiscardItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local chipData = self.chipDataList[index + 1]
  if chipData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
  end
  ChipDiscardItem:InitDiscardChipItem(self.discardId, chipData, self._OnClick, self.dynPlayer)
  ChipDiscardItem:SetItemSelect(self.selectedData == chipData)
  if self.selectedData == nil and index == 0 then
    self:OnClick(ChipDiscardItem)
  end
end

function UIEpChipDiscard:m_GetItemByData(chipData)
  for k, v in ipairs(self.chipDataList) do
    if v == chipData then
      local index = k - 1
      return self:m_GetItemGoByIndex(index)
    end
  end
end

function UIEpChipDiscard:m_GetItemGoByIndex(index)
  local go = self.ui.chipLoopList:GetCellByIndex(index)
  if go ~= nil then
    local ChipDiscardItem = self.chipItemDic[go]
    return ChipDiscardItem
  end
  return nil
end

function UIEpChipDiscard:OnClick(ChipDiscardItem)
  if ChipDiscardItem == nil then
    return
  end
  if self.selectedData ~= nil and self.selectedData ~= ChipDiscardItem.chipData then
    local lastItem = self:m_GetItemByData(self.selectedData)
    if lastItem ~= nil then
      lastItem:SetItemSelect(false)
    end
  end
  self.selectedData = ChipDiscardItem.chipData
  self.selectChipPrice = ChipDiscardItem.price
  ChipDiscardItem:SetItemSelect(true)
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitEpChipDetail(nil, ChipDiscardItem.chipData, self.dynPlayer, self.resloader, true, eChipDetailPowerType.Subtract, true)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(true)
  local sprite, numStr = ChipDiscardItem:GetEpChipDiscardItemMoneyIconSpriteNum()
  self.chipDetailPanel:GetDetailButtonGroup():InitBtnSelByCost(false, numStr, self._onDiscardChip, sprite)
end

function UIEpChipDiscard:DiscardChip()
  if self.selectedData == nil then
    return
  end
  if self._regOnDiscardCallback ~= nil then
    self._regOnDiscardCallback(self)
    return
  end
  if not self.isOverLimit then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(260))
    return
  end
  cs_MessageCommon.ShowMessageBox(string.format(ConfigData:GetTipContent(287), self.selectedData:GetName(), tostring(self.selectChipPrice)), function()
    self:StartDiscardChip(self.selectedData)
  end, nil)
end

function UIEpChipDiscard:StartDiscardChip(chipData)
  self.explorationNetworkCtrl:CS_EXPLORATION_AlgUpperLimit_Sold(self.position, chipData.dataId, function()
    AudioManager:PlayAudioById(1040)
  end)
  self.selectedData = nil
end

function UIEpChipDiscard:AddChipLimit()
  local currentItemNum = self.dynPlayer:GetItemCount(self.costItemId)
  if currentItemNum >= self.costItemNum then
    self.explorationNetworkCtrl:CS_EXPLORATION_AlgUpperLimit_PurchaseLimit(self.position)
  else
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(275))
    return
  end
end

function UIEpChipDiscard:OnStoreMapClicked()
  self.__mapActiveState = not self.__mapActiveState
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

function UIEpChipDiscard:FromMapBackToUI()
  self.__mapActiveState = false
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

function UIEpChipDiscard:m_SwitchMapBtnState(openMap)
  if openMap then
    self.ui.tex_MapBtnName:SetIndex(1)
  else
    self.ui.tex_MapBtnName:SetIndex(0)
  end
  self.ui.frameNode:SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

function UIEpChipDiscard:CloseEpDiscard()
  if self._regOnCloseCallback ~= nil then
    self._regOnCloseCallback(self)
    return
  end
  if self.isOverLimit then
    return
  end
  self.explorationNetworkCtrl:CS_EXPLORATION_AlgUpperLimit_Exit(self.position, function()
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.DiscardChip)
    self:OnWinClose()
  end)
end

function UIEpChipDiscard:OnChipDetailActiveChange(active)
  if active then
    self:Hide()
  else
    self:Show()
  end
end

function UIEpChipDiscard:OnWinClose()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIEpChipDiscard:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self.__OnChipLimitChange)
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.ui.chipLoopList.gameObject:SetActive(false)
  for k, v in pairs(self.chipItemDic) do
    v:OnDelete()
  end
  base.OnDelete(self)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
end

function UIEpChipDiscard:OnDeleteEntity()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.chipItemDic = nil
  self.chipDetailPanel:Delete()
  base.OnDeleteEntity(self)
end

return UIEpChipDiscard
