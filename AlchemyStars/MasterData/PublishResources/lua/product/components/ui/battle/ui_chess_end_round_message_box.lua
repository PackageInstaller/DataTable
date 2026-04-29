_class("UIChessEndRoundMessageBox", UIMessageBox)
UIChessEndRoundMessageBox = UIChessEndRoundMessageBox

function UIChessEndRoundMessageBox:OnShow()
  self._blurMaskObject = self:GetGameObject("BlurMask")
  self._blurMask = self:GetUIComponent("H3DUIBlurHelper", "BlurMask")
  self._blurMaskObject:SetActive(true)
  local camera = GameGlobal.UIStateManager():GetMessageBoxCamera()
  self._blurMask.OwnerCamera = camera
  self._blurMask:RefreshBlurTexture()
end

function UIChessEndRoundMessageBox:ClearCallback()
  self._okCallback = nil
  self._cancelCallback = nil
end

function UIChessEndRoundMessageBox:Alert(popup, params)
  self._blurMask:RefreshBlurTexture()
  self._okCallback = self:GetCallBack(popup, params[1])
  self._cancelCallback = self:GetCallBack(popup, params[2])
end

function UIChessEndRoundMessageBox:ButtonOKOnClick()
  if self._okCallback then
    self._okCallback()
  end
end

function UIChessEndRoundMessageBox:ButtonCancelOnClick()
  if self._cancelCallback then
    self._cancelCallback()
  end
end
