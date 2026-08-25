local UICompCopyBattleStatisticTeamHeader, Super = NewViewComponent("UICompCopyBattleStatisticTeamHeader")
local TYPEOF_Z1Toggle = typeof(CS.Z1Client.Z1Toggle)

function UICompCopyBattleStatisticTeamHeader:ctor(uiNode, view, ownerList, selectedOwnerId, onSelectOwnerId, showRoundColor, ownerColorMap)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Panel_CopyStatisticsResource(uiNode)
  self._ownerList = ownerList or {}
  self._selectedOwnerId = tonumber(selectedOwnerId) or 0
  self._itemList = {}
  self._ownerIdMap = {}
  self._onSelectOwnerId = onSelectOwnerId
  self._showRoundColor = true == showRoundColor
  self._ownerColorMap = ownerColorMap or {}
  self._isSyncingToggle = false
  self._lastTouchedOwnerId = nil
end

function UICompCopyBattleStatisticTeamHeader:OnEnterComponent()
  if self.ui.Tab_AllAwaker then
    self:AddZ1ToggleValueChangedListener(self.ui.Tab_AllAwaker, System.bind(self._OnOwnerToggleValueChanged, self, self.ui.Tab_AllAwaker, 0))
    self:_AddOwnerToggleTouchedListener(self.ui.Tab_AllAwaker, 0)
  end
  self:SyncBySelectedOwnerId(self._selectedOwnerId)
  self:_Refresh()
end

function UICompCopyBattleStatisticTeamHeader:Refresh(ownerList, selectedOwnerId, showRoundColor, ownerColorMap)
  self._ownerList = ownerList or {}
  if nil ~= selectedOwnerId then
    self._selectedOwnerId = tonumber(selectedOwnerId) or 0
  end
  if nil ~= showRoundColor then
    self._showRoundColor = true == showRoundColor
  end
  if nil ~= ownerColorMap then
    self._ownerColorMap = ownerColorMap or {}
  end
  self:SyncBySelectedOwnerId(self._selectedOwnerId)
  self:_Refresh()
end

function UICompCopyBattleStatisticTeamHeader:SyncBySelectedOwnerId(selectedOwnerId)
  self._selectedOwnerId = tonumber(selectedOwnerId) or 0
  self._isSyncingToggle = true
  if self.ui.Tab_AllAwaker then
    self:_SetOwnerToggleState(self.ui.Tab_AllAwaker, 0 == self._selectedOwnerId)
  end
  for _, itemGo in ipairs(self._itemList) do
    if itemGo and not IsNil(itemGo) then
      local ownerId = self._ownerIdMap[itemGo]
      if ownerId then
        self:_SetOwnerToggleState(itemGo, 0 ~= ownerId and ownerId == self._selectedOwnerId)
      end
    end
  end
  self._isSyncingToggle = false
end

function UICompCopyBattleStatisticTeamHeader:_GetOwnerIdByRow(row)
  if CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row) then
    return 1
  end
  if row and row.awakerData and row.awakerData.tid then
    return tonumber(row.awakerData.tid) or 0
  end
  return 0
end

function UICompCopyBattleStatisticTeamHeader:_Refresh()
  local templateGo = self.ui.UI_Dungeons_Item_StatisticsTeam
  local groupGo = self.ui.Group_TeamData
  if not templateGo or not groupGo then
    return
  end
  local count = #self._ownerList
  if count <= 0 then
    templateGo:SetActive(false)
    self:_HideUnusedItems(0)
    return
  end
  templateGo:SetActive(true)
  local parent = groupGo.transform
  self._isSyncingToggle = true
  for i, row in ipairs(self._ownerList) do
    local itemGo = self:_GetOrCreateItem(i, templateGo, parent)
    local ownerId = self:_GetOwnerIdByRow(row)
    self._ownerIdMap[itemGo] = ownerId
    itemGo:SetActive(true)
    self:_RefreshItemContent(itemGo, row)
    self:_SetOwnerToggleState(itemGo, 0 ~= ownerId and ownerId == self._selectedOwnerId)
    self:AddZ1ToggleValueChangedListener(itemGo, System.bind(self._OnOwnerToggleValueChanged, self, itemGo, ownerId))
    self:_AddOwnerToggleTouchedListener(itemGo, ownerId)
  end
  self._isSyncingToggle = false
  self:_HideUnusedItems(count)
end

function UICompCopyBattleStatisticTeamHeader:_AddOwnerToggleTouchedListener(itemGo, ownerId)
  if not itemGo or IsNil(itemGo) then
    return
  end
  local toggle = itemGo:GetComponent(TYPEOF_Z1Toggle)
  if not toggle then
    return
  end
  toggle.onToggleTouched:AddListener(System.bind(self._OnOwnerToggleTouched, self, ownerId))
end

function UICompCopyBattleStatisticTeamHeader:_OnOwnerToggleTouched(ownerId)
  self._lastTouchedOwnerId = ownerId
end

function UICompCopyBattleStatisticTeamHeader:_GetOrCreateItem(index, templateGo, parent)
  local itemGo = self._itemList[index]
  if itemGo then
    return itemGo
  end
  if 1 == index then
    itemGo = templateGo
  else
    itemGo = self:Instantiate(templateGo, parent)
    itemGo.name = string.format("%s_Auto_%d", templateGo.name, index)
  end
  self._itemList[index] = itemGo
  return itemGo
end

function UICompCopyBattleStatisticTeamHeader:_OnOwnerToggleValueChanged(itemGo, ownerId, isOn)
  if self._isSyncingToggle then
    return
  end
  if not self._onSelectOwnerId then
    return
  end
  if nil == ownerId then
    return
  end
  if isOn then
    if ownerId ~= self._lastTouchedOwnerId then
      self:BindTimer(0, 0, nil, System.bind(self._ResolveOwnerToggleValueChanged, self, itemGo, ownerId))
      return
    end
    self._lastTouchedOwnerId = nil
    self._onSelectOwnerId(ownerId)
    return
  end
  if ownerId == self._selectedOwnerId then
    self:BindTimer(0, 0, nil, System.bind(self._RestoreTeamItemToggleIfStillSelected, self, itemGo, ownerId))
  end
end

function UICompCopyBattleStatisticTeamHeader:_ResolveOwnerToggleValueChanged(itemGo, ownerId)
  if ownerId == self._lastTouchedOwnerId then
    self._lastTouchedOwnerId = nil
    if self._onSelectOwnerId then
      self._onSelectOwnerId(ownerId)
    end
    return
  end
  self:_RestoreSelectedOwnerToggles()
end

function UICompCopyBattleStatisticTeamHeader:_RestoreSelectedOwnerToggles()
  self:SyncBySelectedOwnerId(self._selectedOwnerId)
end

function UICompCopyBattleStatisticTeamHeader:_RestoreTeamItemToggleIfStillSelected(itemGo, ownerId)
  if not itemGo or IsNil(itemGo) then
    return
  end
  if ownerId == self._selectedOwnerId then
    self:_SetOwnerToggleState(itemGo, true)
  end
end

function UICompCopyBattleStatisticTeamHeader:_SetOwnerToggleState(itemGo, isOn)
  if not itemGo or IsNil(itemGo) then
    return
  end
  self:SetZ1Toggle(itemGo, isOn, true)
  self:_SyncToggleVisualGroups(itemGo, isOn)
end

function UICompCopyBattleStatisticTeamHeader:_SyncToggleVisualGroups(itemGo, isOn)
  local transform = itemGo.transform
  if not transform then
    return
  end
  local groupSelect = transform:Find("Group_Select")
  if groupSelect then
    groupSelect.gameObject:SetActive(isOn)
  end
  local groupSelected = transform:Find("Group_Selected")
  if groupSelected then
    groupSelected.gameObject:SetActive(isOn)
  end
  local groupNormal = transform:Find("Group_Normal")
  if groupNormal then
    groupNormal.gameObject:SetActive(not isOn)
  end
end

function UICompCopyBattleStatisticTeamHeader:_RefreshItemContent(itemGo, row)
  local ui = UI_Dungeons_Item_StatisticsTeamResource(itemGo)
  if CopyBattleStatisticsDataUtils.IsPlayerStatisticRow(row) then
    self:_RefreshPlayerContent(ui, row)
  elseif row.awakerData and row.awakerData.tid then
    self:_RefreshAwakerContent(ui, row)
  end
  if ui.Image_Assist then
    self:SetActive(ui.Image_Assist, self:_ShouldShowAssistTag(row))
  end
  self:_RefreshRoundColor(ui, row)
end

function UICompCopyBattleStatisticTeamHeader:_RefreshRoundColor(ui, row)
  if not ui.Image_Score then
    return
  end
  self:SetActive(ui.Image_Score, self._showRoundColor == true)
  if not self._showRoundColor then
    return
  end
  local ownerId = self:_GetOwnerIdByRow(row)
  local mapped = self._ownerColorMap and self._ownerColorMap[ownerId]
  if nil == mapped then
    return
  end
  self:SetImageColor(ui.Image_Score, mapped)
end

function UICompCopyBattleStatisticTeamHeader:_ShouldShowAssistTag(row)
  if not (row and row.awakerData) or not row.awakerData.tid then
    return false
  end
  do return CopyBattleStatisticsDataUtils.IsAssistStatisticRow end
  return CopyBattleStatisticsDataUtils.IsAssistStatisticRow, row
end

function UICompCopyBattleStatisticTeamHeader:_RefreshAwakerContent(ui, row)
  local awakerData = row.awakerData
  if ui.Text_Awaker_Name then
    self:SetText(ui.Text_Awaker_Name, LT.Text(AwakerCfgUtils.GetCfgField("Name", awakerData.tid)))
  end
  if ui.Image_Awaker_Head then
    local headIcon = AwakerDataUtils.GetLittleIcon(awakerData.tid, nil, awakerData.curSkin)
    if headIcon and "" ~= headIcon then
      self:SetImage(ui.Image_Awaker_Head, headIcon)
    end
  end
end

function UICompCopyBattleStatisticTeamHeader:_RefreshPlayerContent(ui, row)
  if ui.Text_Awaker_Name then
    self:SetText(ui.Text_Awaker_Name, CopyBattleStatisticsDataUtils.ResolvePlayerDisplayName(row))
  end
  if ui.Image_Awaker_Head then
    local headIcon = CopyBattleStatisticsDataUtils.ResolvePlayerBattleHeadRes(row)
    self:SetImage(ui.Image_Awaker_Head, headIcon or "")
  end
end

function UICompCopyBattleStatisticTeamHeader:_HideUnusedItems(count)
  for i = count + 1, #self._itemList do
    local itemGo = self._itemList[i]
    if itemGo then
      itemGo:SetActive(false)
    end
  end
end

return UICompCopyBattleStatisticTeamHeader
