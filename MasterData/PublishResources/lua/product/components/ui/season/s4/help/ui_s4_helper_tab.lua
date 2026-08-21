_class("UIS4HelperTab", UICustomWidget)
UIS4HelperTab = UIS4HelperTab

function UIS4HelperTab:OnShow(uiParams)
  self:InitWidget()
end

function UIS4HelperTab:InitWidget()
  self._tabNameText = self:GetUIComponent("UILocalizationText", "TabName")
  self._selectedGo = self:GetGameObject("SelectedImg")
  self._unselectedGo = self:GetGameObject("UnselectedImg")
  if self._selectedGo then
    self._selectedGo:SetActive(false)
  end
  if self._unselectedGo then
    self._unselectedGo:SetActive(false)
  end
end

function UIS4HelperTab:OnHide()
end

function UIS4HelperTab:TabBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._callback then
    self._callback(self._tabId)
  end
end

function UIS4HelperTab:SetData(tabCfg, callback)
  self._tabCfg = tabCfg
  self._tabId = self._tabCfg.TabEnum
  self._callback = callback
  self._tabNameText:SetText(StringTable.Get(self._tabCfg.Title))
end

function UIS4HelperTab:OnSelectIndex(tabId)
  if self._tabId == tabId then
    self._tabNameText.color = Color(1.0, 1.0, 1.0, 1)
  else
    self._tabNameText.color = Color(0.7412, 0.7412, 0.7412, 1)
  end
  if self._selectedGo then
    self._selectedGo:SetActive(self._tabId == tabId)
  end
  if self._unselectedGo then
    self._unselectedGo:SetActive(self._tabId ~= tabId)
  end
end
