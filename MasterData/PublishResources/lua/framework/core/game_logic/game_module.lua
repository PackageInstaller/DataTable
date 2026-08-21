_class("GameModule", Object)
GameModule = GameModule

function GameModule:Constructor()
  self.logic = nil
  self.caller = nil
  self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
end

function GameModule:AttachEvent(gameEventType, func)
  self.autoBinder:BindEvent(gameEventType, self, func)
end

function GameModule:DetachEvent(gameEventType)
  self.autoBinder:UnBindEvent(gameEventType)
end

function GameModule:Init()
end

function GameModule:Dispose()
end

function GameModule:DetachAllEvents()
  self.autoBinder:UnBindAllEvents()
end

function GameModule:Update(cur_tick)
end

function GameModule:GetModule(type)
  return self.logic:GetModule(type)
end

function GameModule:GetUIModule(type)
  if type == nil then
    type = self
  end
  return GameGlobal.GetUIModule(type)
end

function GameModule:Call(TT, request, sync, timeout)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule then
    local lastGuideid = guideModule:GetLastCompleteGuide()
    if lastGuideid ~= 0 then
      request.flag = lastGuideid
      guideModule:ReportCompleteGuide(lastGuideid)
    end
  end
  sync = sync == nil and true or sync
  timeout = timeout == nil and (sync and 10000 or 15000) or timeout
  if GameSingle then
    timeout = 0.1
  end
  return self.caller:Call(TT, request, sync, timeout) or ReplyInfo:New()
end

function GameModule:Push(msg)
  self.caller:Push(msg)
end
