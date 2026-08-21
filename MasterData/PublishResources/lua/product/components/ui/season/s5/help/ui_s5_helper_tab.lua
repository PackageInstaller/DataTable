_class("UIS5HelperTab", UICustomWidget)
UIS5HelperTab = UIS5HelperTab

function UIS5HelperTab:OnShow(uiParams)
  self:InitWidget()
end

function UIS5HelperTab:InitWidget()
  self._tabNameText = self:GetUIComponent("UILocalizationText", "TabName")
  self._tabName2Text = self:GetUIComponent("UILocalizationText", "TabName2")
  self._selectedGo = self:GetGameObject("SelectedImg")
  self._unselectedGo = self:GetGameObject("UnselectedImg")
  if self._selectedGo then
    self._selectedGo:SetActive(false)
  end
  if self._unselectedGo then
    self._unselectedGo:SetActive(false)
  end
end

function UIS5HelperTab:OnHide()
end

function UIS5HelperTab:TabBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._callback then
    self._callback(self._tabId)
  end
end

function UIS5HelperTab:SetData(tabCfg, callback)
  self._tabCfg = tabCfg
  self._tabId = self._tabCfg.TabEnum
  self._callback = callback
  local str = StringTable.Get(self._tabCfg.Title)
  self._tabNameText:SetText(str)
  self._tabName2Text:SetText(str)
end

function UIS5HelperTab:OnSelectIndex(tabId)
  if self._selectedGo then
    self._selectedGo:SetActive(self._tabId == tabId)
  end
  if self._unselectedGo then
    self._unselectedGo:SetActive(self._tabId ~= tabId)
  end
end
