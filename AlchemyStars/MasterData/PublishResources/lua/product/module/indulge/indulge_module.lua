_enum("IndulgeRes", {
  Tips = 1,
  Logout = 2,
  OpenUrl = 3
})
_class("IndulgeModule", GameModule)
IndulgeModule = IndulgeModule

function IndulgeModule:Constructor()
  self._info = nil
end

function IndulgeModule:Init()
  IndulgeModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventNotifyIndulgeState, self.HandleMsg, self)
end

function IndulgeModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventNotifyIndulgeState)
  IndulgeModule.super.Dispose(self)
end

function IndulgeModule:Update()
end

function IndulgeModule:IsIndulge()
  return self._info ~= nil and true or false
end

function IndulgeModule:GetAndClearInfo()
  local info = self._info
  self._info = nil
  return info
end

function IndulgeModule:HandleMsg(msg)
  if msg == nil or msg.info == nil then
    return
  end
  self:SetMsgInfo(msg.info)
end

function IndulgeModule:SetMsgInfo(info)
  if info == nil then
    return
  end
  if self._info ~= nil then
    if self._info.type == IndulgeRes.Logout then
    elseif self._info.type == IndulgeRes.Tips then
      self._info = info
    end
  else
    self._info = info
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.IndulgeDataEvent)
end
