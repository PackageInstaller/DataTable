local _PopupPriority = {
  Invalid = 0,
  Normal = 1,
  Guide = 2,
  Network = 3,
  System = 4
}
_enum("PopupPriority", _PopupPriority)
PopupPriority = PopupPriority
_class("PopupManager", Singleton)
PopupManager = PopupManager
local PrefabSuffix = ".prefab"
local SHALLOW_COPY = table.shallowcopy

function PopupManager:Constructor()
  self.popupList = ArrayList:New()
  self.curPopup = nil
  self.priorityFilter = PopupPriority.Normal
  self.name2MsgBox = {}
  self.switchLock = false
end

function PopupManager:Dispose()
  if self.name2MsgBox then
    local name2MsgBox = SHALLOW_COPY(self.name2MsgBox)
    for k, v in pairs(name2MsgBox) do
      v:UnLoad()
      v:Dispose()
    end
  end
end

function PopupManager.Alert(uiMsgBoxName, priority, ...)
  if GameGlobal:GetInstance():IsDisposing() then
    Log.debug("[UIPopup] PopupManager.Alert return,cause game disposing,", uiMsgBoxName, debug.traceback())
    return
  else
    Log.debug("[UIPopup] PopupManager.Alert,", uiMsgBoxName, debug.traceback())
  end
  local popup = Popup:New(uiMsgBoxName, priority, ...)
  GameGlobal.UIStateManager():ShowPopup(popup)
  return popup
end

function PopupManager:GetSwitchLock()
  return self.switchLock
end

function PopupManager:SetSwitchLock(value)
  Log.debug("[UIPopup] PopupManager:SetSwitchLock,", value)
  self.switchLock = value
end

function PopupManager:SetPopupPriorityFilter(TT, value, bOnlyFilter)
  if value then
    if not bOnlyFilter then
      self.priorityFilter = value
    end
    local deletePopup = {}
    for i = 1, self.popupList:Size() do
      local popup = self.popupList:GetAt(i)
      if value > popup:Priority() then
        deletePopup[#deletePopup + 1] = popup
      end
    end
    for i = 1, #deletePopup do
      local popup = deletePopup[i]
      self:ClosePopup(TT, popup)
    end
  end
end

function PopupManager:GetPriorityFilter()
  return self.priorityFilter
end

function PopupManager:OpenPopup(TT, popup)
  if not popup then
    Log.fatal("[UIPopup] PopupManager:OpenPopup, popup is nil,return")
    return
  end
  if popup:Priority() < self.priorityFilter then
    Log.fatal("[UIPopup] PopupManager:OpenPopup, priority=", popup:Priority(), " is lower than filter=", self.priorityFilter, ",return")
    return
  end
  local index = self.popupList:Find(popup)
  if index ~= -1 then
    Log.fatal("[UIPopup] PopupManager:OpenPopup, popup had open,return")
    return
  end
  if not self.curPopup or popup:Priority() > self.curPopup:Priority() then
    Log.debug("[UIPopup] PopupManager:OpenPopup,", popup.uiMsgBoxName, ", open and add to popuplist")
    if self.curPopup then
      self.curPopup:Close(TT, false)
    end
    self.curPopup = popup
    self.curPopup:Open(TT)
  else
    Log.debug("[UIPopup] PopupManager:OpenPopup,", popup.uiMsgBoxName, ", just add to popuplist")
  end
  local index = -1
  for i = 1, self.popupList:Size() do
    local p = self.popupList:GetAt(i)
    if popup:Priority() > p:Priority() then
      index = i
      break
    end
  end
  if index < 0 then
    self.popupList:PushBack(popup)
  else
    self.popupList:Insert(popup, index)
  end
end

function PopupManager:ClosePopup(TT, popup)
  if not popup then
    Log.fatal("[UIPopup] PopupManager:ClosePopup, popup is nil,return")
    return
  end
  local oldSize = self.popupList:Size()
  local index = self.popupList:Remove(popup)
  if self.curPopup == popup then
    Log.debug("[UIPopup] PopupManager:ClosePopup ", popup.uiMsgBoxName, " which is curPopup, close and remove from popuplist")
    popup:Close(TT)
    if self.popupList:Size() > 0 then
      self.curPopup = self.popupList:GetAt(1)
      Log.debug("[UIPopup] PopupManager:ClosePopup, open popup ", self.curPopup.uiMsgBoxName, " from popupList")
      self.curPopup:Open(TT)
    else
      self.curPopup = nil
    end
  elseif oldSize == 0 then
    Log.debug("[UIPopup] PopupManager:ClosePopup ", popup.uiMsgBoxName, " which isn't curPopup, and popuplist is empty")
  elseif index == -1 then
    Log.debug("[UIPopup] PopupManager:ClosePopup ", popup.uiMsgBoxName, " which isn't curPopup, not in popuplist")
  else
    Log.debug("[UIPopup] PopupManager:ClosePopup ", popup.uiMsgBoxName, " which isn't curPopup, just remove from popuplist")
  end
end

function PopupManager:GetUIMessageBox(TT, uiMsgBoxName)
  local uiMsgBox = self.name2MsgBox[uiMsgBoxName]
  if uiMsgBox then
    return true, uiMsgBox
  else
    local uiMsgBox = self:CreateUIMessageBox(uiMsgBoxName)
    if not uiMsgBox then
      return
    end
    uiMsgBox:SetName(uiMsgBoxName)
    local uiView, resRequest = UIResourceManager.GetViewAsync(TT, uiMsgBoxName, uiMsgBoxName .. PrefabSuffix)
    if not uiView then
      Log.fatal("[UI] PopupManager:GetUIMessageBox Error, View is Null, ", uiMsgBoxName)
      return
    end
    return false, uiMsgBox, uiView, resRequest
  end
end

function PopupManager:SetUIMessageBox(uiMsgBoxName, uiMsgBox, uiView, resRequest)
  if uiMsgBox == nil or uiView == nil then
    return
  end
  uiMsgBox:Load(uiView, resRequest)
  self.name2MsgBox[uiMsgBoxName] = uiMsgBox
end

function PopupManager:Clear(TT)
  if self.curPopup then
    self.curPopup:Close(TT)
    self.curPopup = nil
  end
  self.popupList:Clear()
end

function PopupManager:GetCurShowingPriority()
  if not self.curPopup then
    return PopupPriority.Invalid
  end
  return self.curPopup:Priority()
end

function PopupManager:HasPopup()
  return self.popupList:Size() > 0
end

function PopupManager:CreateUIMessageBox(uiMsgBoxName)
  local uiMsgBox = _createInstance(uiMsgBoxName)
  if not uiMsgBox then
    Log.fatal("[UI] PopupManager:CreateUIMessageBox Error, No UIMessageBox of name = ", uiMsgBoxName)
  end
  if not uiMsgBox:IsChildOf("UIMessageBox") then
    Log.fatal("[UI] PopupManager:CreateUIMessageBox Fail, ", uiMsgBoxName, " is not inherited from UIMessageBox!")
    return
  end
  return uiMsgBox
end
