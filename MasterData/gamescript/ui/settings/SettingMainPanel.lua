local UIAnimationController = CS.Z1Client.UIAnimationController
local SettingItemType = CommonDefine.SettingItemType
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
local SettingMainPanel, Super = System.NewClass("SettingMainPanel", UIBasePanel)
SettingMainPanel.uiResCls = UI_Setting_Popup_MainResource

function SettingMainPanel:ctor()
  Super.ctor(self)
  self.toggleObjGroup = {}
end

function SettingMainPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(SettingMainPanelModel)
  self.model = model
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    textTitleCN = LT.Text("SettingPanelTitle"),
    clickFunc = System.fn(self, self.OnClose)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupTipsData))
  if model.toggleList[1] then
    model.SetCurSelectTab(model.toggleList[1])
  end
  binder:BindToCircularListView(self.ui.ScrollView_Toggle, function()
    return model.toggleList
  end, function(itemBinder, item, index)
    local toggleName = model.toggleList[index]
    if toggleName == model.curSelectTab then
      itemBinder:SetZ1Toggle(item, true)
    end
    local tempUI = UI_Setting_Item_ToggleResource(item)
    itemBinder:BindToZ1Toggle(item, nil, function(isOn)
      if isOn then
        local uiAnimController = item:GetComponent(typeof(UIAnimationController))
        uiAnimController:PlayState("UI_Setting_Item_Toggle_Select")
        model.SetCurSelectTab(toggleName)
      end
    end, function()
      return self.model.curSelectTab == toggleName
    end)
    itemBinder:SetActive(tempUI.Group_Buuble, false)
    binder:SetText(tempUI.Text_Toggle, LT.Text(DT.CommonID[toggleName].Desc))
    itemBinder:BindComponent(RedDotComponent(tempUI.Com_RedDot, CommonDefine.RedDotType.Dot, function()
      local tabList = model.allContentMap[toggleName]
      do return SettingManager.Instance.EnableRedByTab, SettingManager.Instance end
      return SettingManager.Instance.EnableRedByTab, SettingManager.Instance, tabList
    end))
  end)
  for i = 1, 6 do
    if self.ui["ScrollView_Content_" .. i] then
      self.ui["ScrollView_Content_" .. i]:SetActive(false)
    end
  end
  for i, tabType in ipairs(self.model.toggleList) do
    binder:BindToVisible(self.ui["ScrollView_Content_" .. i], function()
      return self.model.curSelectTab == tabType
    end)
    binder:BindNormalListView(self.ui["ScrollView_Content_" .. i], function()
      do return model.GetContentList, model end
      return model.GetContentList, model, tabType
    end, function(index)
      local contentData = model:GetContentList(tabType)[index]
      do return self.GetPrefabType end
      return self.GetPrefabType, contentData.itemType
    end, function(itemBinder, item, index)
      local contentData = model:GetContentList(tabType)[index]
      if contentData.itemType == SettingItemType.Space then
        return
      end
      itemBinder:BindComponent(itemTypeCompMap[contentData.itemType](item, contentData))
    end)
  end
  binder:BindToRaw(function(itemBinder, nVal)
    for i, tabType in pairs(self.model.toggleList) do
      if nVal == tabType then
        itemBinder:ListViewJumpToIndex(self.ui["ScrollView_Content_" .. i], 1)
        EventMgr.Instance.GraphicSetting:Dispatch()
        return
      end
    end
  end, function()
    return model.curSelectTab
  end)
  binder:BindToVisible(self.ui.Btn_DebugGM, function()
    do return end
    return ApplicationUtils.is_open_gm, nil
  end)
  if ApplicationUtils.is_open_gm() then
    binder:BindZ1Button(self.ui.Btn_DebugGM, function()
      UIManager.Instance:Reopen(Urls.GmPanel)
    end)
  end
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:BindEvent(EventMgr.Instance.ShortCutRecording, System.fn(self, self.OnShortCutRecording))
end

function SettingMainPanel:OnShortCutRecording(isRecording)
  if isRecording then
    self:SetIgnorePushBackCommand()
    self.binder:StopTimer(self.resetBackCommandTimer)
  else
    self.resetBackCommandTimer = self.binder:BindTimer(0.5, 0, nil, System.fn(self, self.ReSetIgnorePushBackCommand))
  end
end

function SettingMainPanel.GetPrefabType(type)
  if itemTypePrefabNameMap[type] then
    return itemTypePrefabNameMap[type]
  end
  return "UI_Setting_Content_Date"
end

function SettingMainPanel:OnClose()
  MobileFileDataManager.Instance:OnSaveCommInfo()
  self:Close()
end

return SettingMainPanel
