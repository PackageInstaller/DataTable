_class("Popup", Object)
Popup = Popup

function Popup:Constructor(uiMsgBoxName, priority, ...)
  self.uiMsgBoxName = uiMsgBoxName
  self.priority = priority or PopupPriority.Normal
  self.params = {
    ...
  }
end

function Popup:Priority(value)
  if value then
    self.priority = value
  else
    return self.priority
  end
end

function Popup:Open(TT)
  if not GameGlobal.UIStateManager() then
    Log.fatal("[UIPopup] Popup:Open UIStateManager is nil, return")
    return
  end
  local uiMsgBox = GameGlobal.UIStateManager():GetUIMessageBox(TT, self.uiMsgBoxName, true)
  if not uiMsgBox then
    Log.fatal("[UIPopup] Popup:Open cannot find uiMsgBox named ", self.uiMsgBoxName, ", return")
    return
  end
  Log.debug("[UIPopup] Popup:Open,", self.uiMsgBoxName)
  uiMsgBox:Alert(self, self.params)
  uiMsgBox:SetShow(true)
end

function Popup:Close(TT, clearCallback)
  clearCallback = clearCallback ~= false
  local uiMsgBox = GameGlobal.UIStateManager():GetUIMessageBox(TT, self.uiMsgBoxName, false)
  if not uiMsgBox then
    return
  end
  Log.debug("[UIPopup] Popup:Close,", self.uiMsgBoxName)
  if clearCallback then
    Log.debug("[UIPopup] Popup:Close,", self.uiMsgBoxName, ",clearCallback")
    uiMsgBox:ClearCallback()
  end
  uiMsgBox:SetShow(false)
end
