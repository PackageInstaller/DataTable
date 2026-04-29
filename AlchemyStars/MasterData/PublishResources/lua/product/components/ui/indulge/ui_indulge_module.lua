_class("UIIndulgeModule", UIModule)
UIIndulgeModule = UIIndulgeModule
local eCode = 100

function UIIndulgeModule:Constructor()
  self._modal = false
  self._Module = self:GetModule(IndulgeModule)
  self:AttachEvent(GameEventType.IndulgeDataEvent, self.HandleData)
  self:AttachEvent(GameEventType.SwitchUIStateFinish, self.UIHandle)
  
  function self._NoticeRetEvent(ret)
    self:NoticeRetEvent(ret)
  end
  
  SDKProxy:GetInstance():WebViewRetEvent(self._NoticeRetEvent, true)
end

function UIIndulgeModule:Dispose()
  SDKProxy:GetInstance():WebViewRetEvent(self._NoticeRetEvent, false)
end

function UIIndulgeModule:NoticeRetEvent(ret)
  Log.debug("[indulge] ", "NoticeRetEvent type:", ret.MsgType, ", modal", self._modal and "true" or "false")
  if self._modal == false then
    return
  end
  self._modal = false
  if ret.MsgType ~= eCode then
    return
  end
  if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.LoginEmpty then
  else
    GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
  end
end

function UIIndulgeModule:HandleData()
  self:ShowUI()
end

function UIIndulgeModule:UIHandle(uiStateType)
  self:ShowUI()
end

function UIIndulgeModule:ShowUI()
  if self._Module == nil or self._Module:IsIndulge() == false then
    return
  end
  local curUIState = GameGlobal.UIStateManager():CurUIStateType()
  if curUIState == UIStateType.BattleLoading or curUIState == UIStateType.UIBattle then
    return
  end
  local info = self._Module:GetAndClearInfo()
  if info == nil then
    return
  end
  self._modal = false
  Log.debug("[indulge] ", "indulge type:", info.type, ", title:", info.title, ", msg:", info.msg, ", url:", info.url)
  if info.type == IndulgeRes.Tips then
    self:HandleTips(info)
  elseif info.type == IndulgeRes.Logout then
    self:HandleLogout(info)
  elseif info.type == IndulgeRes.OpenUrl then
    self._modal = info.modal == 1 and true or false
    self:HandleOpenUrl(info)
  else
    Log.error("UIIndulgeModule type error")
  end
end

function UIIndulgeModule:HandleTips(info)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, info.title, info.msg)
end

function UIIndulgeModule:HandleLogout(info)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, info.title, info.msg, function()
    if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.LoginEmpty then
    else
      GameGlobal.GameLogic():BackToLogin(false, LoginModule, "player logout", false)
    end
  end)
end

function UIIndulgeModule:HandleOpenUrl(info)
  SDKProxy:GetInstance():OpenUrl(info.url)
end
