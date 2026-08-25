local BackTrackSelectView, Super = NewClass("BackTrackSelectView", BaseView)
BackTrackSelectView.uiResCls = UI_Awaker_Popup_Backtrace_TipResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)

function BackTrackSelectView:ctor(itemId)
  Super.ctor(self)
  self._itemId = itemId
  self._tabSelectedTidDict = {}
  self._awakerTableView = nil
  self._weaponTableView = nil
  self._itemDetailBinder = nil
  self._isFirstRefresh = true
end

function BackTrackSelectView:OnBuildView()
  BackTrackSelectModel.Instance:SetItemId(self._itemId)
  self:_BuildAwakerListView()
  self:_BuildWeaponListView()
end

function BackTrackSelectView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self._OnClickClose))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  self:AddButtonClickListener(self.ui.Btn_Details, System.fn(self, self._OnClickDetail))
  local tRelativeUIs = {
    [CommonDefine.BackTrackType.NormalAwaker] = self.ui.Btn_Bookmark_1,
    [CommonDefine.BackTrackType.UniqueAwaker] = self.ui.Btn_Bookmark_2,
    [CommonDefine.BackTrackType.Weapon] = self.ui.Btn_Bookmark_3
  }
  self._tabRelativeUIs = tRelativeUIs
  for tabType, toggleUi in pairs(tRelativeUIs) do
    self:AddZ1ToggleValueChangedListener(toggleUi, function(isOn)
      if isOn then
        self:_OnTabChanged(tabType)
      end
    end)
  end
end

function BackTrackSelectView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAwakerPotentiaUpgrade, self._OnAwakerDataChanged, self)
  self:RegisterNotify(NotifyId.OnAwakerLevelUp, self._OnAwakerDataChanged, self)
end

function BackTrackSelectView:_OnAwakerDataChanged()
  BackTrackSelectModel.Instance:MarkListDirty()
  self:_RefreshAll()
end

function BackTrackSelectView:OnEnterView()
  Super.OnEnterView(self)
  DBGTeamDataUtils.ReqShowTeam(CommonDefine.TeamType.Special)
  self:_OnTabChanged(CommonDefine.BackTrackType.NormalAwaker)
end

function BackTrackSelectView:OnExitView()
  self:_TeardownItemDetailBinder()
  Super.OnExitView(self)
end

function BackTrackSelectView:_TeardownItemDetailBinder()
  if self._itemDetailBinder then
    self._itemDetailBinder:teardown()
    self._itemDetailBinder = nil
  end
end

function BackTrackSelectView:_GetItemDetailBinder()
  self:_TeardownItemDetailBinder()
  self._itemDetailBinder = self.binder:createChild()
  return self._itemDetailBinder
end

function BackTrackSelectView:_RefreshAll()
  local model = BackTrackSelectModel.Instance
  local curTab = model:GetCurTab()
  local list
  if curTab == CommonDefine.BackTrackType.Weapon then
    list = model:GetWeaponList()
  else
    list = model:GetAwakerList()
  end
  self._currentList = list
  self:_RefreshTabState()
  self:_RefreshLists()
  self:_RefreshEmptyState()
  self:_RefreshButtonStates()
  self._isFirstRefresh = false
end

function BackTrackSelectView:_RefreshTabState()
  local curTab = BackTrackSelectModel.Instance:GetCurTab()
  for tabType, toggleUi in pairs(self._tabRelativeUIs) do
    local isOn = tabType == curTab
    if isOn then
      if tabType == CommonDefine.BackTrackType.Weapon then
        self:SetActive(self.ui.ScrollView_Thing, true)
        self:SetActive(self.ui.ScrollView_Awake, false)
      else
        self:SetActive(self.ui.ScrollView_Awake, true)
        self:SetActive(self.ui.ScrollView_Thing, false)
      end
    end
    self:SetZ1Toggle(toggleUi, isOn)
  end
end

function BackTrackSelectView:_RefreshLists()
  local curTab = BackTrackSelectModel.Instance:GetCurTab()
  if curTab == CommonDefine.BackTrackType.Weapon then
    self:_RestoreWeaponSelection()
    if self._weaponTableView then
      self._weaponTableView:ReloadData()
    end
  else
    self:_RestoreAwakerSelection()
    if self._awakerTableView then
      self._awakerTableView:ReloadData()
    end
  end
end

function BackTrackSelectView:_RestoreWeaponSelection()
  local model = BackTrackSelectModel.Instance
  local list = self._currentList
  if not list or #list <= 0 then
    return
  end
  local curTab = model:GetCurTab()
  local curSelectedIndex
  if self._isFirstRefresh then
    curSelectedIndex = 1
  else
    curSelectedIndex = self:_FindIndexByTid(list, self._tabSelectedTidDict[curTab])
  end
  if curSelectedIndex and curSelectedIndex <= #list then
    local weaponItem = list[curSelectedIndex]
    model:SetCurWeaponUid(weaponItem.uid)
    model:SetCurWeaponTid(weaponItem.tid)
  end
end

function BackTrackSelectView:_RefreshEmptyState()
  local isEmpty = not self._currentList or #self._currentList <= 0
  self:SetActive(self.ui.Group_Null_Black, isEmpty)
  self:SetActive(self.ui.Btn_Confirm, not isEmpty)
  self:SetActive(self.ui.Btn_Details, not isEmpty)
end

function BackTrackSelectView:_RefreshButtonStates()
  local model = BackTrackSelectModel.Instance
  local curTab = model:GetCurTab()
  local isSelected = false
  local isInTask = false
  if curTab == CommonDefine.BackTrackType.Weapon then
    isSelected = model:GetCurWeaponUid() ~= nil and 0 ~= model:GetCurWeaponUid()
  else
    local awakerId = model:GetCurAwakerId()
    isSelected = nil ~= awakerId and 0 ~= awakerId
    if isSelected then
      isInTask = TaskDataUtils.AwakerInTask(awakerId)
    end
  end
  local canConfirm = isSelected and not isInTask
  if canConfirm then
    self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.High)
  else
    self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.Unclickable)
  end
  if isSelected then
    self:SetButtonState(self.ui.Btn_Details, CommonDefine.BtnType.High)
  else
    self:SetButtonState(self.ui.Btn_Details, CommonDefine.BtnType.Unclickable)
  end
end

function BackTrackSelectView:_OnTabChanged(tabType)
  BackTrackSelectModel.Instance:SetCurTab(tabType)
  self:_RefreshAll()
  self:_ScrollToTop()
end

function BackTrackSelectView:_ScrollToTop()
  local curTab = BackTrackSelectModel.Instance:GetCurTab()
  local scrollGo = curTab == CommonDefine.BackTrackType.Weapon and self.ui.ScrollView_Thing or self.ui.ScrollView_Awake
  if scrollGo then
    local scrollRect = scrollGo:GetComponent(T_ScrollRect)
    if scrollRect then
      scrollRect.verticalNormalizedPosition = 1
    end
  end
end

function BackTrackSelectView:_BuildAwakerListView()
  local prefab = self.ui.UI_Awaker_Item_List
  local cellW, cellH = prefab.transform.sizeDelta.x, prefab.transform.sizeDelta.y
  self._awakerCellPrefab = prefab
  self._awakerTableView = self:CreateTableview(self.ui.ScrollView_Awake, function()
    return self._currentList and #self._currentList or 0
  end, function(view, idx)
    do return self._OnAwakerCellAtIndex, self, view, self._currentList end
    return self._OnAwakerCellAtIndex, self, view, self._currentList, idx
  end, function()
    return cellW, cellH
  end)
end

function BackTrackSelectView:_OnAwakerCellAtIndex(view, list, idx)
  local awakerData = list[idx]
  if not awakerData then
    return nil
  end
  local cell = self:DequeueCell(view, self._awakerCellPrefab)
  local itemData = {
    awakerData = awakerData,
    clickFunc = function()
      local curTab = BackTrackSelectModel.Instance:GetCurTab()
      self._tabSelectedTidDict[curTab] = awakerData.tid
      BackTrackSelectModel.Instance:SetCurAwakerId(awakerData.tid)
      self:_RefreshButtonStates()
      if self._awakerTableView then
        self._awakerTableView:ReloadData()
      end
    end,
    selectFunc = function()
      return awakerData.tid == BackTrackSelectModel.Instance:GetCurAwakerId()
    end,
    wrongBgFunc = function()
      do return TaskDataUtils.AwakerInTask end
      return TaskDataUtils.AwakerInTask, awakerData.tid
    end,
    showPotencyInfoFunc = function()
      do return AwakerDataUtils.HasOwnedAwaker end
      return AwakerDataUtils.HasOwnedAwaker, awakerData.tid
    end
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicAwakerListItem, itemData)
  return cell
end

function BackTrackSelectView:_RestoreAwakerSelection()
  local model = BackTrackSelectModel.Instance
  local curTab = model:GetCurTab()
  local list = self._currentList
  if not list or #list <= 0 then
    return
  end
  local curSelectedIndex
  if self._isFirstRefresh then
    curSelectedIndex = 1
  else
    curSelectedIndex = self:_FindIndexByTid(list, self._tabSelectedTidDict[curTab])
  end
  if curSelectedIndex and curSelectedIndex <= #list then
    local awakerData = list[curSelectedIndex]
    model:SetCurAwakerId(awakerData.tid)
  end
end

function BackTrackSelectView:_FindIndexByTid(list, tid)
  if not tid then
    return 1
  end
  for i, item in ipairs(list) do
    if item.tid == tid then
      return i
    end
  end
  return 1
end

function BackTrackSelectView:_BuildWeaponListView()
  local prefab = self.ui.UI_Common_Item_WuPin_Type1
  local cellW, cellH = prefab.transform.sizeDelta.x, prefab.transform.sizeDelta.y
  self._weaponCellPrefab = prefab
  self._weaponTableView = self:CreateTableview(self.ui.ScrollView_Thing, function()
    return self._currentList and #self._currentList or 0
  end, function(view, idx)
    do return self._OnWeaponCellAtIndex, self, view, self._currentList end
    return self._OnWeaponCellAtIndex, self, view, self._currentList, idx
  end, function()
    return cellW, cellH
  end)
end

function BackTrackSelectView:_OnWeaponCellAtIndex(view, list, idx)
  local value = list[idx]
  if not value then
    return nil
  end
  local cell = self:DequeueCell(view, self._weaponCellPrefab)
  local itemData = {
    tid = value.tid,
    uid = value.uid,
    callback = function()
      local curTab = BackTrackSelectModel.Instance:GetCurTab()
      self._tabSelectedTidDict[curTab] = value.tid
      BackTrackSelectModel.Instance:SetCurWeaponUid(value.uid)
      BackTrackSelectModel.Instance:SetCurWeaponTid(value.tid)
      self:_RefreshButtonStates()
      if self._weaponTableView then
        self._weaponTableView:ReloadData()
      end
    end,
    ShowRedDot = false,
    ShowLockImg = false,
    ShowOwnAwaker = false,
    clickFrameShowFunc = function()
      return value.uid == BackTrackSelectModel.Instance:GetCurWeaponUid()
    end,
    showName = true
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType1, itemData)
  return cell
end

function BackTrackSelectView:_OnClickClose()
  self:Close()
end

function BackTrackSelectView:_OnClickConfirm()
  local model = BackTrackSelectModel.Instance
  local curTab = model:GetCurTab()
  local isSelected = false
  if curTab == CommonDefine.BackTrackType.Weapon then
    isSelected = model:GetCurWeaponUid() ~= nil and 0 ~= model:GetCurWeaponUid()
  else
    isSelected = nil ~= model:GetCurAwakerId() and 0 ~= model:GetCurAwakerId()
  end
  if not isSelected then
    return
  end
  local name = ""
  local selectId = 0
  local isInTask = false
  if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
    name = AwakerDataUtils.GetAwakerName(model:GetCurAwakerId())
    selectId = model:GetCurAwakerId()
    isInTask = TaskDataUtils.AwakerInTask(model:GetCurAwakerId())
  else
    selectId = model:GetCurWeaponUid()
    name = ItemDataUtils.GetItemName(model:GetCurWeaponTid())
  end
  
  local function reqFunc()
    BackTrackController.Instance:ReqUseBacktrackItem(model:GetItemId(), model:GetChooseTid(), function()
      self:_UseBackItemSuccess(name, selectId)
      self:Close()
    end)
  end
  
  local backTips = 20114
  if isInTask then
    backTips = 20126
    Alert.Show(backTips)
  else
    if curTab == CommonDefine.BackTrackType.UniqueAwaker then
      Alert.ShowWithParams(20165, {name}, nil, reqFunc)
      return
    end
    if curTab == CommonDefine.BackTrackType.Weapon and ItemDataUtils.CheckIsMaxLvSSRWeapon(selectId) and DBGTeamDataUtils.IsTogetherWithSSRWeapon(selectId) then
      Alert.ShowWithParams(20213, {name}, nil, reqFunc)
    else
      Alert.ShowWithParams(backTips, {name}, nil, reqFunc)
    end
  end
end

function BackTrackSelectView:_UseBackItemSuccess(name, selectId)
  local function confirmFunc()
    local curTab = BackTrackSelectModel.Instance:GetCurTab()
    
    if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
      local awakerBasePanelData = {
        jumpPage = CommonDefine.AwakerPage.BackTrack,
        selectAwakerId = selectId
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    else
      UIManager.Instance:Reopen(Urls.AwakerWeaponStrengthPanel, selectId, true)
    end
  end
  
  local tipsId = 20116
  local desc = LT.Textf(DT.TipsType[tipsId].Desc, name)
  Alert.Show(tipsId, nil, confirmFunc, nil, desc)
end

function BackTrackSelectView:_OnClickDetail()
  local model = BackTrackSelectModel.Instance
  local curTab = model:GetCurTab()
  local isSelected = false
  if curTab == CommonDefine.BackTrackType.Weapon then
    isSelected = model:GetCurWeaponUid() ~= nil and 0 ~= model:GetCurWeaponUid()
  else
    isSelected = nil ~= model:GetCurAwakerId() and 0 ~= model:GetCurAwakerId()
  end
  if not isSelected then
    return
  end
  if curTab == CommonDefine.BackTrackType.NormalAwaker or curTab == CommonDefine.BackTrackType.UniqueAwaker then
    local function panelOpenFunc()
      local awakerId = model:GetCurAwakerId()
      
      if not awakerId or 0 == awakerId then
        return
      end
      local awakerBasePanelData = {}
      awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
      awakerBasePanelData.specialAwakerList = {
        AwakerDataUtils.GetAwakerData(awakerId)
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    end
    
    FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
  else
    local weaponUid = model:GetCurWeaponUid()
    local weaponTid = model:GetCurWeaponTid()
    ItemDataUtils.ShowItemDetailTips(self:_GetItemDetailBinder(), self.ui.Group_Top, weaponUid, weaponTid, true)
  end
end

return BackTrackSelectView
