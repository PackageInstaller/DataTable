local base = require("Game.Exploration.UI.ChipDiscard.UIEpChipDiscardBase")
local UIEpChipDiscardRoom = class("UIEpChipDiscardRoom", base)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon

function UIEpChipDiscardRoom:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  base.OnInit(self)
  self.netCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnStoreMapClicked)
  UIUtil.AddButtonListener(self.ui.btn_AddTotalCount, self, self.AddChipLimit)
  self._FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self._FromMapBackToUI)
end

function UIEpChipDiscardRoom:OnShow()
  base.OnShow(self)
  self:SetChipListSellBtnActive(false)
end

function UIEpChipDiscardRoom:OnHide()
  base.OnHide(self)
  self:SetChipListSellBtnActive(true)
end

function UIEpChipDiscardRoom:InitEpChipDiscard(dynPlayer, closeCallback, needConsumeSkill)
  base.InitEpChipDiscard(self, dynPlayer, closeCallback, needConsumeSkill)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  local opDetail = dynPlayer:GetOperatorDetail()
  self.position = opDetail.curPostion
  self.__mapActiveState = false
  self:_SwitchMapBtnState(self.__mapActiveState)
end

function UIEpChipDiscardRoom:OnStoreMapClicked()
  self.__mapActiveState = not self.__mapActiveState
  self:_SwitchMapBtnState(self.__mapActiveState)
end

function UIEpChipDiscardRoom:FromMapBackToUI()
  self.__mapActiveState = false
  self:_SwitchMapBtnState(self.__mapActiveState)
end

function UIEpChipDiscardRoom:_SwitchMapBtnState(openMap)
  if openMap then
    self.ui.tex_MapBtnName:SetIndex(1)
  else
    self.ui.tex_MapBtnName:SetIndex(0)
  end
  self.ui.frameNode:SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

function UIEpChipDiscardRoom:AddChipLimit()
  local currentItemNum = self.dynPlayer:GetItemCount(self.costItemId)
  if currentItemNum >= self.costItemNum then
    self.netCtrl:CS_EXPLORATION_AlgUpperLimit_PurchaseLimit(self.position)
  else
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(275))
    return
  end
end

function UIEpChipDiscardRoom:BackAction()
  base.CloseEpDiscard(self)
  if self.isOverLimit then
    return false
  end
  self.netCtrl:CS_EXPLORATION_AlgUpperLimit_Exit(self.position, function()
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.DiscardChip)
    self:OnWinClose()
  end)
end

function UIEpChipDiscardRoom:CloseEpDiscard()
  base.CloseEpDiscard(self)
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpChipDiscardRoom:OnDiscardChip()
  base.OnDiscardChip(self)
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

function UIEpChipDiscardRoom:StartDiscardChip(chipData)
  self.netCtrl:CS_EXPLORATION_AlgUpperLimit_Sold(self.position, chipData.dataId, function()
    AudioManager:PlayAudioById(1040)
  end)
  self.selectedData = nil
end

function UIEpChipDiscardRoom:InitDiscardChipItem(item, chipData, index)
  item:InitDiscardChipItem(self.discardId, chipData, self._onDiscardItemClick, self.dynPlayer)
  item:SetItemSelect(self.selectedData == chipData)
  if self.selectedData == nil and index == 0 then
    self:_OnDiscardItemClick(item)
  end
end

function UIEpChipDiscardRoom:SetChipListSellBtnActive(active)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if win ~= nil then
    win:TrySetLimitSellBtnActive(active)
  end
end

function UIEpChipDiscardRoom:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self._FromMapBackToUI)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
end

return UIEpChipDiscardRoom
