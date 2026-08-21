_class("UISeasonHelperTabS2", UICustomWidget)
UISeasonHelperTabS2 = UISeasonHelperTabS2

function UISeasonHelperTabS2:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonHelperTabS2:InitWidget()
  self._tabNameText = self:GetUIComponent("UILocalizationText", "TabName")
  self._selectedGo = self:GetGameObject("SelectedImg")
  self._selectedGo:SetActive(false)
end

function UISeasonHelperTabS2:OnHide()
end

function UISeasonHelperTabS2:TabBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._callback then
    self._callback(self._tabId)
  end
end

function UISeasonHelperTabS2:SetData(tabCfg, callback)
  self._tabCfg = tabCfg
  self._tabId = self._tabCfg.TabEnum
  self._callback = callback
  self._tabNameText:SetText(StringTable.Get(self._tabCfg.Title))
end

function UISeasonHelperTabS2:OnSelectIndex(tabId)
  if self._tabId == tabId then
    self._selectedGo:SetActive(true)
    self._tabNameText.color = Color(0.769, 0.576, 0.208, 1)
  else
    self._selectedGo:SetActive(false)
    self._tabNameText.color = Color(0.541, 0.416, 0.282, 1)
  end
end
