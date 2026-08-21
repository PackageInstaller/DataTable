_class("UINewCommonTopButton", UICustomWidget)
UINewCommonTopButton = UINewCommonTopButton

function UINewCommonTopButton:Constructor()
  self._shareModule = self:GetModule(ShareModule)
end

function UINewCommonTopButton:OnShow(uiParams)
  self._shareBtn = self:GetGameObject("ShareBtn")
  local extraWidget = {
    "TeamRecordBtn"
  }
  for _, v in ipairs(extraWidget) do
    self:GetGameObject(v):SetActive(false)
  end
end

function UINewCommonTopButton:SetData_Extra(params)
  self._extra = {}
  for i, v in ipairs(params) do
    local widget = v[1]
    local callback = v[2]
    local obj = self:GetGameObject(widget)
    if obj then
      obj:SetActive(true)
      self._extra[widget] = callback
    end
  end
end

function UINewCommonTopButton:SetData(_backCB, _helpCB, _thumbCB, _hideHomeBtn, showHideUICB, showShareBtn, shareCB)
  self.backCallback = _backCB
  self.helpCallback = _helpCB
  self.thumbCB = _thumbCB
  self.showHideUICB = showHideUICB
  self.showShareBtn = showShareBtn
  self.shareCB = shareCB
  if self.helpCallback == nil then
    self:GetGameObject("ButtonHelp"):SetActive(false)
  else
    self:GetGameObject("ButtonHelp"):SetActive(true)
  end
  if _hideHomeBtn then
    self:HideHomeBtn()
  end
  if self.showHideUICB == nil then
    self:GetGameObject("btnShowHideUI"):SetActive(false)
  end
  if self.showShareBtn then
    self._shareBtn:SetActive(self._shareModule:CanShare())
  else
    self._shareBtn:SetActive(false)
  end
end

function UINewCommonTopButton:OnHide()
end

function UINewCommonTopButton:ButtonBackOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonBackOnClick", {}, true)
  self.backCallback()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end

function UINewCommonTopButton:ButtonThumbOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonThumbOnClick", {}, true)
  if self.thumbCB then
    self.thumbCB()
  else
    UICommonHelper:GetInstance():SwitchToUIMain()
  end
end

function UINewCommonTopButton:ButtonHelpOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonHelpOnClick", {}, true)
  self.helpCallback()
end

function UINewCommonTopButton:HideHomeBtn()
  self:GetGameObject("ButtonThumb"):SetActive(false)
end

function UINewCommonTopButton:BtnShowHideUIOnClick(go)
  if self.showHideUICB then
    self.showHideUICB()
  end
end

function UINewCommonTopButton:ShareBtnOnClick(go)
  if self.shareCB then
    self.shareCB()
  end
end

function UINewCommonTopButton:SetShareBtn(show, shareCB)
  self._shareBtn:SetActive(show and self._shareModule:CanShare())
  self.shareCB = shareCB
end

function UINewCommonTopButton:TeamRecordBtnOnClick(go)
  local widget = "TeamRecordBtn"
  if self._extra[widget] then
    self._extra[widget]()
  end
end
