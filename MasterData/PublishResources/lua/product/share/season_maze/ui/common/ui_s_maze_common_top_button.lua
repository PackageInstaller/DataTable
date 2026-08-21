_class("UISMazeCommonTopButton", UICustomWidget)
UISMazeCommonTopButton = UISMazeCommonTopButton

function UISMazeCommonTopButton:Constructor()
  self._shareModule = self:GetModule(ShareModule)
end

function UISMazeCommonTopButton:OnShow(uiParams)
  self._shareBtn = self:GetGameObject("ShareBtn")
  self._plotBtn = self:GetGameObject("BtnPlot")
  local extraWidget = {
    "TeamRecordBtn"
  }
  for _, v in ipairs(extraWidget) do
    self:GetGameObject(v):SetActive(false)
  end
end

function UISMazeCommonTopButton:SetData_Extra(params)
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

function UISMazeCommonTopButton:SetData(_backCB, _helpCB, _thumbCB, _hideHomeBtn, showHideUICB, showShareBtn, shareCB, plotCb)
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
  self._plotCb = plotCb
  self._plotBtn:SetActive(self._plotCb ~= nil)
end

function UISMazeCommonTopButton:OnHide()
end

function UISMazeCommonTopButton:BtnPlotOnClick(go)
  if self._plotCb then
    self._plotCb()
  end
end

function UISMazeCommonTopButton:ButtonBackOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonBackOnClick", {}, true)
  self.backCallback()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end

function UISMazeCommonTopButton:ButtonThumbOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonThumbOnClick", {}, true)
  if self.thumbCB then
    self.thumbCB()
  else
    UICommonHelper:GetInstance():SwitchToUIMain()
  end
end

function UISMazeCommonTopButton:ButtonHelpOnClick(go)
  GameGlobal.UAReportForceGuideEvent("ButtonHelpOnClick", {}, true)
  self.helpCallback()
end

function UISMazeCommonTopButton:HideHomeBtn()
  self:GetGameObject("ButtonThumb"):SetActive(false)
end

function UISMazeCommonTopButton:BtnShowHideUIOnClick(go)
  if self.showHideUICB then
    self.showHideUICB()
  end
end

function UISMazeCommonTopButton:ShareBtnOnClick(go)
  if self.shareCB then
    self.shareCB()
  end
end

function UISMazeCommonTopButton:SetShareBtn(show, shareCB)
  self._shareBtn:SetActive(show and self._shareModule:CanShare())
  self.shareCB = shareCB
end

function UISMazeCommonTopButton:TeamRecordBtnOnClick(go)
  local widget = "TeamRecordBtn"
  if self._extra[widget] then
    self._extra[widget]()
  end
end
