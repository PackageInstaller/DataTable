_class("UIEmptyController", UIController)
UIEmptyController = UIEmptyController

function UIEmptyController:OnShow(uiParams)
  self._pos = self:GetUIComponent("RectTransform", "pos")
  self._safe = self:GetUIComponent("RectTransform", "SafeArea")
  local pos = uiParams[1]
  local size = uiParams[2]
  if self._pos then
    self._pos.position = pos + self._safe.position
    self._pos.sizeDelta = size
  end
  self._callback = uiParams[3]
  if uiParams[5] then
    self._homeCall = uiParams[4]
  else
    self._homeCall = false
  end
  self:UnLock("UIPowerOpened")
end

function UIEmptyController:Dispose()
end

function UIEmptyController:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIEmptyClose)
end

function UIEmptyController:Constructor()
end

function UIEmptyController:bgOnClick()
  if self._callback then
    self:_callback()
  end
  self:CloseDialog()
end

function UIEmptyController:OnAppHome()
  if self._homeCall then
    self:bgOnClick()
  end
end
