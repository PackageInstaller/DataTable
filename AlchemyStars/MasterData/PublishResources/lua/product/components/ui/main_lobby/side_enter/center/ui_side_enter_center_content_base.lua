_class("UISideEnterCenterContentBase", UICustomWidget)
UISideEnterCenterContentBase = UISideEnterCenterContentBase
local ESideEnterContentType = {Single = 1, Center = 2}
_enum("ESideEnterContentType", ESideEnterContentType)

function UISideEnterCenterContentBase:OnInit(type, closeCallback, hideUICallback, data, params)
  self._type = type
  self._closeCallback = closeCallback
  self._hideUICallback = hideUICallback
  self._data = data
  self:DoInit(params)
end

function UISideEnterCenterContentBase:CloseDialog(isPlayer)
  if isPlayer and self._type == ESideEnterContentType.Center then
    return
  end
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISideEnterCenterContentBase:SetCenterUIHide(hide)
  if self._hideUICallback then
    self._hideUICallback(hide)
  end
end

function UISideEnterCenterContentBase:IsEnableUpdate()
  return self._enableUpdate
end

function UISideEnterCenterContentBase:EnableUpdate(enableUpdate)
  self._enableUpdate = enableUpdate
end

function UISideEnterCenterContentBase:DoInit()
  Log.exception(self._className .. "必须重写DoInit()方法:", debug.traceback())
end

function UISideEnterCenterContentBase:DoShow()
  Log.exception(self._className .. "必须重写OnShow()方法:", debug.traceback())
end

function UISideEnterCenterContentBase:DoHide()
  Log.exception(self._className .. "必须重写OnHide()方法:", debug.traceback())
end

function UISideEnterCenterContentBase:DoDestroy()
  Log.exception(self._className .. "必须重写OnDestroy()方法:", debug.traceback())
end

function UISideEnterCenterContentBase:DoUpdate(deltaTimeMS)
end
