_class("UISeasonHelperTab", UICustomWidget)
UISeasonHelperTab = UISeasonHelperTab

function UISeasonHelperTab:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonHelperTab:InitWidget()
  self._tabNameText = self:GetUIComponent("UILocalizationText", "TabName")
  self._selectedGo = self:GetGameObject("SelectedImg")
  self._selectedGo:SetActive(false)
end

function UISeasonHelperTab:OnHide()
end

function UISeasonHelperTab:TabBtnOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._callback then
    self._callback(self._tabId)
  end
end

function UISeasonHelperTab:SetData(tabCfg, callback)
  self._tabCfg = tabCfg
  self._tabId = self._tabCfg.TabEnum
  self._callback = callback
  self._tabNameText:SetText(StringTable.Get(self._tabCfg.Title))
end

function UISeasonHelperTab:OnSelectIndex(tabId)
  if self._tabId == tabId then
    self._selectedGo:SetActive(true)
    self._tabNameText.color = Color(1.0, 0.9490196078431372, 0.8274509803921568, 1)
  else
    self._selectedGo:SetActive(false)
    self._tabNameText.color = Color(0.8156862745098039, 0.8156862745098039, 0.807843137254902, 1)
  end
end
