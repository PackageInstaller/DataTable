_class("UIModule", Object)
UIModule = UIModule

function UIModule:Constructor()
  self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
end

function UIModule:Dispose()
  self.autoBinder:Dispose()
end

function UIModule:AttachEvent(gameEventType, func)
  self.autoBinder:BindEvent(gameEventType, self, func)
end

function UIModule:DetachEvent(gameEventType)
  self.autoBinder:UnBindEvent(gameEventType)
end

function UIModule:DetachAllEvents()
  self.autoBinder:UnBindAllEvents()
end

function UIModule:GetModule(type)
  return GameGlobal.GetModule(type)
end

function UIModule:GetUIModule(gameModuleProto)
  return GameGlobal.GetUIModule(gameModuleProto)
end

function UIModule:StartTask(func, ...)
  GameGlobal.TaskManager():StartTask(func, ...)
end

function UIModule:AttachEvent(gameEventType, func)
  self.autoBinder:BindEvent(gameEventType, self, func)
end

function UIModule:DetachEvent(gameEventType)
  self.autoBinder:UnBindEvent(gameEventType)
end

function UIModule:DetachAllEvents()
  self.autoBinder:UnBindAllEvents()
end
