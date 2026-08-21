_class("UICommonTopButton", UICustomWidget)
UICommonTopButton = UICommonTopButton

function UICommonTopButton:Constructor()
end

function UICommonTopButton:OnShow(uiParams)
  self._campaign = nil
end

function UICommonTopButton:SetData(_backCB, _helpCB, _thumbCB, _hideHomeBtn, showHideUICB)
  self.backCallback = _backCB
  self.helpCallback = _helpCB
  self.thumbCB = _thumbCB
  self.showHideUICB = showHideUICB
  if self.helpCallback == nil then
    self:GetGameObject("ButtonHelp"):SetActive(false)
  end
  if _hideHomeBtn then
    self:HideHomeBtn()
  end
  if self.showHideUICB == nil then
    self:GetGameObject("btnShowHideUI"):SetActive(false)
  end
end

function UICommonTopButton:OnHide()
end

function UICommonTopButton:ButtonBackOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonBackOnClick", {}, true)
  self.backCallback()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end

function UICommonTopButton:ButtonThumbOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonThumbOnClick", {}, true)
  if self.thumbCB then
    self.thumbCB()
  else
    UICommonHelper:GetInstance():SwitchToUIMain()
  end
end

function UICommonTopButton:ButtonHelpOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonHelpOnClick", {}, true)
  self.helpCallback()
end

function UICommonTopButton:HideHomeBtn()
  self:GetGameObject("ButtonThumb"):SetActive(false)
end

function UICommonTopButton:btnShowHideUIOnClick(go)
  if self.showHideUICB then
    self.showHideUICB()
  end
end
