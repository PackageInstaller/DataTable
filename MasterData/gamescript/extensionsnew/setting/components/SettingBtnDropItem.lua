local SettingBtnDropItem, Super = NewViewComponent("SettingBtnDropItem", SettingContentBaseItem)

function SettingBtnDropItem:OnEnterComponent()
  self:_InitBaseUIElement()
  self._dropList = SettingModel.Instance:GetDropList(self.data.range)
  self._curDropData = SettingModel.Instance:GetDropInitData(self.data)
  self:_RefreshDropText()
  self:AddZ1ToggleValueChangedListener(self.ui.Group_Drop, function(isOn)
    if isOn then
      self:_OpenDropPopup()
    end
  end)
  self:BindEvent(EventMgr.Instance.GraphicSetting, System.fn(self, self._OnGraphicSetting))
end

function SettingBtnDropItem:_RefreshDropText()
  self:SetText(self.ui.Text_Drop_Tips, LT.Text(self._curDropData or ""))
end

function SettingBtnDropItem:_OnGraphicSetting()
  local newDropData = SettingModel.Instance:GetDropInitData(self.data)
  if newDropData then
    self._curDropData = newDropData
    self:_RefreshDropText()
  end
end

function SettingBtnDropItem:_OpenDropPopup()
  local data = {
    dropList = self._dropList,
    parentNode = self.ui.Group_Drop_Sel,
    curText = self._curDropData,
    setUpUid = self.data.setUpUid,
    setupTab = self.data.setupTab,
    clickFunc = System.fn(self, self._OnDropSelected)
  }
  UIManager.Instance:Reopen(Urls.SettingDropGroupView, data)
end

function SettingBtnDropItem:_OnDropSelected(newText, setVal)
  self:SetZ1Toggle(self.ui.Group_Drop, false)
  if not newText then
    return
  end
  self._curDropData = newText
  self:_RefreshDropText()
  SettingManager.Instance:SetSettingData(self.data.setUpUid, setVal)
  if self.data.setUpUid == CommonDefine.SettingUniqueName.GraphicQuality then
    SettingManager.Instance:EnableSetting(self.data.tid, self._dropList)
  else
    SettingManager.Instance:EnableSetting(self.data.tid, self._dropList, true)
  end
end

return SettingBtnDropItem
