local SettingItemType = CommonDefine.SettingItemType
local ConfirmTipsType = CommonDefine.ConfirmTipsType
local TYPEOF_SCROLL_RECT = typeof(CS.UnityEngine.UI.ScrollRect)
local itemTypeCompMap = {
  [SettingItemType.Title] = SettingTitleItem,
  [SettingItemType.SliderText] = SettingSliderTextItem,
  [SettingItemType.SliderNoText] = SettingSliderNoTextItem,
  [SettingItemType.BtnToggle] = SettingBtnToggleItem,
  [SettingItemType.BtnSingle] = SettingBtnSingleItem,
  [SettingItemType.BtnDrop] = SettingBtnDropItem,
  [SettingItemType.BundleShortcutKey] = SettingBundleShortcutKeyItem
}
local itemTypePrefabNameMap = {
  [SettingItemType.Title] = "UI_Setting_Content_Title",
  [SettingItemType.SliderNoText] = "UI_Setting_Content_Performance",
  [SettingItemType.BundleShortcutKey] = "UI_Setting_Content_ShortcutKey",
  [SettingItemType.Space] = "Group_Interval"
}
local DEFAULT_CONTENT_PREFAB = "UI_Setting_Content_Date"
local TAB_ITEM_PREFAB = "UI_Setting_Item_Toggle"
local MAX_CONTENT_VIEW = 6
local itemTypeTagMap = {
  [SettingItemType.Title] = 1,
  [SettingItemType.SliderText] = 2,
  [SettingItemType.SliderNoText] = 3,
  [SettingItemType.BtnToggle] = 4,
  [SettingItemType.BtnSingle] = 5,
  [SettingItemType.BtnDrop] = 6,
  [SettingItemType.BundleShortcutKey] = 7,
  [SettingItemType.Space] = 8
}
local SettingMainView, Super = NewClass("SettingMainView", BaseView)
SettingMainView.uiResCls = UI_Setting_Popup_MainResource

function SettingMainView:ctor()
  Super.ctor(self)
  self._toggleList = {}
  self._allContentMap = {}
  self._contentDataMap = {}
  self._contentTableViews = {}
  self._contentTemplateRoot = nil
  self._contentTemplateCache = {}
  self._loggedInvalidItems = {}
  self._loggedMissingRoot = false
  self._resetBackCommandTimer = nil
end

function SettingMainView:OnBuildView()
  self:_InitPopupTips()
  self:_InitGmButton()
  self:_BuildTabTableView()
  self:_HideAllContent()
  self:_BuildContentTableViews()
  self:_RefreshContentVisibility()
end

function SettingMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnSettingTabChanged, self._OnTabChanged, self)
end

function SettingMainView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  if ApplicationUtils.is_open_gm() then
    self:AddButtonClickListener(self.ui.Btn_DebugGM, function()
      UIManager.Instance:Reopen(Urls.GmPanel)
    end)
  end
  self:BindEvent(EventMgr.Instance.ShortCutRecording, System.fn(self, self._OnShortCutRecording))
end

function SettingMainView:_InitPopupTips()
  local data = {
    sizeType = ConfirmTipsType.L,
    textTitleCN = "SettingPanelTitle",
    clickFunc = System.fn(self, self._OnClose)
  }
  self:AddViewComponent(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, data)
end

function SettingMainView:_InitGmButton()
  self.ui.Btn_DebugGM.gameObject:SetActive(ApplicationUtils.is_open_gm())
end

function SettingMainView:_BuildTabTableView()
  self._toggleList = SettingModel.Instance:GetToggleList()
  self._allContentMap = SettingModel.Instance:GetAllContentMap()
  if self._toggleList[1] then
    SettingModel.Instance:SetCurSelectTab(self._toggleList[1])
  end
  local scrollGo = self.ui.ScrollView_Toggle
  if not scrollGo then
    Logger.Error("SettingMainView:_BuildTabTableView 缺少 ScrollView_Toggle 节点，页签列表未创建")
    return
  end
  local template = self.ui[TAB_ITEM_PREFAB]
  if not template then
    Logger.Error("SettingMainView:_BuildTabTableView 缺少页签模板节点: ", TAB_ITEM_PREFAB)
  end
  local width, height = self:_GetTemplateSize(template)
  self._tabTableView = self:CreateTableview(scrollGo, function()
    return #self._toggleList
  end, function(view, idx)
    do return self._OnTabCellAtIndex, self, view end
    return self._OnTabCellAtIndex, self, view, idx
  end, function()
    return width, height
  end)
  self._tabTableView:ReloadData()
end

function SettingMainView:_OnTabCellAtIndex(view, idx)
  local toggleName = self._toggleList[idx]
  local template = self.ui[TAB_ITEM_PREFAB]
  local cell = self:DequeueCell(view, template)
  local curTab = SettingModel.Instance:GetCurSelectTab()
  self:AddViewComponentOnce(cell.gameObject, SettingTabItem, toggleName, toggleName == curTab, self._allContentMap[toggleName], System.fn(self, self._OnSelectTab))
  return cell
end

function SettingMainView:_OnSelectTab(toggleName)
  SettingModel.Instance:SetCurSelectTab(toggleName)
  self:LocalNotify(NotifyId.OnSettingTabChanged)
end

function SettingMainView:SwitchToTab(tabType)
  if not tabType or not table.contains(self._toggleList, tabType) then
    return
  end
  if SettingModel.Instance:GetCurSelectTab() == tabType then
    return
  end
  SettingModel.Instance:SetCurSelectTab(tabType)
  if self._tabTableView then
    self._tabTableView:ReloadData()
  end
  self:_OnTabChanged()
end

function SettingMainView:_OnTabChanged()
  self:_RefreshContentVisibility()
  EventMgr.Instance.GraphicSetting:Dispatch()
end

function SettingMainView:_HideAllContent()
  for i = 1, MAX_CONTENT_VIEW do
    if self.ui["ScrollView_Content_" .. i] then
      self.ui["ScrollView_Content_" .. i]:SetActive(false)
    end
  end
end

function SettingMainView:_BuildContentTableViews()
  for i, tabType in ipairs(self._toggleList) do
    local scrollGo = self.ui["ScrollView_Content_" .. i]
    if scrollGo then
      self._contentDataMap[tabType] = SettingModel.Instance:GetContentList(tabType)
      local tableView = self:CreateTableview(scrollGo, function()
        return #(self._contentDataMap[tabType] or {})
      end, function(view, idx)
        do return self._OnContentCellAtIndex, self, view, tabType end
        return self._OnContentCellAtIndex, self, view, tabType, idx
      end, function(_, idx)
        do return self._OnContentCellSize, self, tabType end
        return self._OnContentCellSize, self, tabType, idx
      end)
      tableView:ReloadData()
      self._contentTableViews[i] = tableView
    end
  end
end

function SettingMainView:_GetPrefabName(itemType)
  return itemTypePrefabNameMap[itemType] or DEFAULT_CONTENT_PREFAB
end

function SettingMainView:_GetContentTemplateRoot()
  if not self._contentTemplateRoot then
    local dateTemplate = self.ui.UI_Setting_Content_Date
    if dateTemplate then
      self._contentTemplateRoot = dateTemplate.transform.parent
    end
  end
  return self._contentTemplateRoot
end

function SettingMainView:_GetContentTemplate(prefabName)
  local cached = self._contentTemplateCache[prefabName]
  if nil ~= cached then
    return cached or nil
  end
  local root = self:_GetContentTemplateRoot()
  if not root then
    if not self._loggedMissingRoot then
      self._loggedMissingRoot = true
      Logger.Error("SettingMainView:_GetContentTemplate 模板根节点缺失 UI_Setting_Content_Date")
    end
    return nil
  end
  local template
  local child = root:Find(prefabName)
  if child then
    template = child.gameObject
  else
    Logger.Error("SettingMainView:_GetContentTemplate 找不到 cell 模板节点: ", prefabName)
  end
  self._contentTemplateCache[prefabName] = template or false
  return template
end

function SettingMainView:_ReportInvalidItemOnce(data, reason)
  local key = tostring(data.tid) .. "_" .. reason
  if self._loggedInvalidItems[key] then
    return
  end
  self._loggedInvalidItems[key] = true
  Logger.Error("SettingMainView 设置项渲染异常: ", reason, " tid=", tostring(data.tid), " uniqueName=", tostring(data.setUpUid), " itemType=", tostring(data.itemType), " 请检查 Setup 表 ComponenType 与 settingItemTypeMap/itemTypeCompMap 是否同步")
end

function SettingMainView:_OnContentCellAtIndex(view, tabType, idx)
  local data = self._contentDataMap[tabType][idx]
  local itemType = data.itemType
  local tag = itemTypeTagMap[itemType]
  if not tag then
    self:_ReportInvalidItemOnce(data, "未知 itemType，无对应回收标签")
    tag = 0
  end
  local template = self:_GetContentTemplate(self:_GetPrefabName(itemType))
  local cell = self:DequeueCellByTag(view, tag, template)
  if itemType == SettingItemType.Space then
    return cell
  end
  local compCls = itemTypeCompMap[itemType]
  if not compCls then
    self:_ReportInvalidItemOnce(data, "itemType 未注册对应组件类")
    return cell
  end
  self:AddViewComponentOnce(cell.gameObject, compCls, data)
  return cell
end

function SettingMainView:_OnContentCellSize(tabType, idx)
  local data = self._contentDataMap[tabType][idx]
  local template = self:_GetContentTemplate(self:_GetPrefabName(data.itemType))
  do return self._GetTemplateSize, self end
  return self._GetTemplateSize, self, template, self:_GetPrefabName(data.itemType)
end

function SettingMainView:_GetTemplateSize(template)
  if not template then
    return 0, 0
  end
  local sizeDelta = template.transform.sizeDelta
  return sizeDelta.x, sizeDelta.y
end

function SettingMainView:_RefreshContentVisibility()
  local curTab = SettingModel.Instance:GetCurSelectTab()
  for i = 1, MAX_CONTENT_VIEW do
    local scrollGo = self.ui["ScrollView_Content_" .. i]
    if scrollGo then
      local tabType = self._toggleList[i]
      local isShow = nil ~= tabType and curTab == tabType
      scrollGo:SetActive(isShow)
      if isShow then
        self:_ResetContentScroll(scrollGo)
      end
    end
  end
end

function SettingMainView:_ResetContentScroll(scrollGo)
  local scrollRect = scrollGo:GetComponent(TYPEOF_SCROLL_RECT)
  if not scrollRect then
    return
  end
  scrollRect.verticalNormalizedPosition = 1
end

function SettingMainView:_OnShortCutRecording(isRecording)
  if isRecording then
    self:SetIgnorePushBackCommand()
    self:StopTimer(self._resetBackCommandTimer)
  else
    self:StopTimer(self._resetBackCommandTimer)
    self._resetBackCommandTimer = self:BindTimer(0.5, 0, nil, System.fn(self, self.ReSetIgnorePushBackCommand))
  end
end

function SettingMainView:_OnClose()
  MobileFileDataManager.Instance:OnSaveCommInfo()
  self:Close()
end

return SettingMainView
