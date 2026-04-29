_class("UISeasonMazeMessageBox", UIMessageBox)
UISeasonMazeMessageBox = UISeasonMazeMessageBox

function UISeasonMazeMessageBox:Constructor()
  self._okMsgBox = nil
  self._okCancelMsgBox = nil
  self.okCallback = nil
  self.cancelCallback = nil
  self._text = nil
end

function UISeasonMazeMessageBox:Destructor()
  self._okMsgBox = nil
  self._okCancelMsgBox = nil
  self.okCallback = nil
  self.cancelCallback = nil
  self._text = nil
end

function UISeasonMazeMessageBox:OnShow()
  self._okMsgBox = self:GetGameObject("OKMsgBoxRoot")
  self._okCancelMsgBox = self:GetGameObject("OKCancelMsgBoxRoot")
  self._blurMask = self:GetUIComponent("H3DUIBlurHelper", "BlurMask")
  self._blurMaskObject = self:GetGameObject("BlurMask")
  self.tglNotRemind = self:GetUIComponent("Toggle", "tglNotRemind")
  self.tglNotRemind.gameObject:SetActive(false)
  self._blurMaskObject:SetActive(true)
  local camera = GameGlobal.UIStateManager():GetMessageBoxCamera()
  self._blurMask.OwnerCamera = camera
  self._blurMask:RefreshBlurTexture()
end

function UISeasonMazeMessageBox:ClearCallback()
  Log.debug("[msgbox] ClearCallback")
  self.okCallback = nil
  self.cancelCallback = nil
end

function UISeasonMazeMessageBox:Alert(popup, params)
  self._blurMask:RefreshBlurTexture()
  local type = params[1]
  if type == PopupMsgBoxType.Ok then
    self:AlertOK(popup, params)
  elseif type == PopupMsgBoxType.OkCancel then
    self:AlertOKCancel(popup, params)
  end
end

function UISeasonMazeMessageBox:AlertOK(popup, params)
  Log.debug("[msgbox] UISeasonMazeMessageBox AlertOK [", params[2], "]", params[3])
  self._okMsgBox:SetActive(true)
  self._okCancelMsgBox:SetActive(false)
  self._title = self:GetUIComponent("UIRichText", "OKTitle")
  self._title:SetText(params[2])
  self._text = self:GetUIComponent("UIRichText", "OKText")
  self._text:SetText(params[3])
  self.okCallback = self:GetCallBack(popup, params[4], params[5])
  if params[6] then
    self._text.onHrefClick = params[6]
  end
  self._okBtnText = self:GetUIComponent("UILocalizationText", "OkCancelOkBtnText")
  if self._okBtnText then
    if params[7] then
      self._okBtnText:SetText(params[7])
    else
      self._okBtnText:SetText(StringTable.Get("str_common_ok"))
    end
  end
  self.tglNotRemind.gameObject:SetActive(false)
end

function UISeasonMazeMessageBox:AlertOKCancel(popup, params)
  Log.debug("[msgbox] UISeasonMazeMessageBox AlertOKCancel [", params[2], "]", params[3])
  self._okMsgBox:SetActive(false)
  self._okCancelMsgBox:SetActive(true)
  self._title = self:GetUIComponent("UIRichText", "OKCancelTitle")
  self._title:SetText(params[2])
  self._text = self:GetUIComponent("UIRichText", "OKCancelText")
  self._text:SetText(params[3])
  self.okCallback = self:GetCallBack(popup, params[4], params[5])
  self.cancelCallback = self:GetCallBack(popup, params[6], params[7])
  if params[8] then
    self._text.onHrefClick = params[8]
  end
  self._okBtnText = self:GetUIComponent("UILocalizationText", "OkCancelOkBtnText")
  if self._okBtnText then
    if params[9] then
      self._okBtnText:SetText(params[9])
    else
      self._okBtnText:SetText(StringTable.Get("str_common_ok"))
    end
  end
  self._okCancelCancelBtnText = self:GetUIComponent("UILocalizationText", "OkCancelCancelBtnText")
  if self._okCancelCancelBtnText then
    if params[10] then
      self._okCancelCancelBtnText:SetText(params[10])
    else
      self._okCancelCancelBtnText:SetText(StringTable.Get("str_common_cancel"))
    end
  end
  self.toggleTrueCallback = params[11]
  if self.toggleTrueCallback then
    self.tglNotRemind.gameObject:SetActive(true)
  else
    self.tglNotRemind.gameObject:SetActive(false)
  end
end

function UISeasonMazeMessageBox:ButtonOnClick(go)
  Log.debug("[msgbox] UISeasonMazeMessageBox AlertOK click ok")
  if self.okCallback then
    self.okCallback()
  end
end

function UISeasonMazeMessageBox:ButtonOKOnClick(go)
  Log.debug("[msgbox] UISeasonMazeMessageBox AlertOKCancel click ok")
  if self.tglNotRemind.isOn and self.toggleTrueCallback then
    self.toggleTrueCallback()
  end
  if self.okCallback then
    self.okCallback()
  end
end

function UISeasonMazeMessageBox:ButtonCancelOnClick(go)
  Log.debug("[msgbox] UISeasonMazeMessageBox AlertOKCancel click cancel")
  if self.cancelCallback then
    self.cancelCallback()
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end
