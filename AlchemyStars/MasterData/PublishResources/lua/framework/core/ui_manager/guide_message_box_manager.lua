_class("GuidePopup", Object)
GuidePopup = GuidePopup
_class("GuideMessageBoxMng", Singleton)
GuideMessageBoxMng = GuideMessageBoxMng
local PrefabSuffix = ".prefab"

function GuideMessageBoxMng:Constructor()
  self._uiMsgBox = nil
  self.name2MsgBox = {}
  self._guidePopup = nil
end

function GuideMessageBoxMng:Dispose()
end

function GuideMessageBoxMng:OpenGuideBox(uiMsgBoxName, ...)
  GameGlobal.UIStateManager():Lock("OpenGuideBox")
  self.params = {
    ...
  }
  self._guidePopup = GuidePopup:New()
  GameGlobal.TaskManager():StartTask(self._OpenPopup, self, uiMsgBoxName, ...)
  return self._guidePopup
end

function GuideMessageBoxMng:IsGuideBoxShowing()
  return self._uiMsgBox ~= nil
end

function GuideMessageBoxMng:_OpenPopup(TT, uiMsgBoxName, ...)
  local isCache, uiMsgBox, uiView, resRequest = self:GetUIMessageBox(TT, uiMsgBoxName)
  if not isCache then
    GameGlobal.UIStateManager():SetGuideMessageBoxParent(uiView, uiMsgBoxName)
    self:SetUIMessageBox(uiMsgBoxName, uiMsgBox, uiView, resRequest)
  end
  GameGlobal.UIStateManager():CheckMessageBoxCameraStatus(true)
  GameGlobal.UIStateManager():CheckMessageBoxCameraStatus(true)
  self._uiMsgBox = uiMsgBox
  self._uiMsgBox:Alert(self, self.params)
  self._uiMsgBox:SetShow(true)
  GameGlobal.UIStateManager():UnLock("OpenGuideBox")
end

function GuideMessageBoxMng:ClosePopup(popup)
  Log.debug("[guide] GuideMessageBoxMng:ClosePopup")
  if self._uiMsgBox ~= nil then
    self._uiMsgBox:ClearCallback()
    self._uiMsgBox = nil
    self._guidePopup = nil
    GameGlobal.UIStateManager():CheckMessageBoxCameraStatus(false)
  end
end

function GuideMessageBoxMng:GetUIMessageBox(TT, uiMsgBoxName)
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

function GuideMessageBoxMng:SetUIMessageBox(uiMsgBoxName, uiMsgBox, uiView, resRequest)
  if uiMsgBox == nil or uiView == nil then
    return
  end
  uiMsgBox:Load(uiView, resRequest)
  self.name2MsgBox[uiMsgBoxName] = uiMsgBox
end

function GuideMessageBoxMng:CreateUIMessageBox(uiMsgBoxName)
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
