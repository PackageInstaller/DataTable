local ExtensionMgr = NewClass("ExtensionMgr")

function ExtensionMgr:ctor()
  self.setting = nil
  self.dispatchers = {}
  self.views2Extends = {}
end

function ExtensionMgr:Init(setting)
  self.setting = setting
  self:_BuildAllExtensions()
end

function ExtensionMgr:GetDispatcher(id)
  return self.dispatchers[id]
end

function ExtensionMgr:RegisterLocalNotify(viewName, name, handler, handlerObj, priority)
  local views2Extends = self.views2Extends[viewName]
  if not views2Extends then
    Logger.Error("ExtensionMgr:RegisterLocalNotify 绑定错误，View没有关联的扩展模块")
    return
  end
  local ENV = _ENV
  for i = 1, #views2Extends do
    local localDispatcher = self.dispatchers[views2Extends[i]]
    if not localDispatcher then
    else
      localDispatcher:AddListener(name, handler, handlerObj, priority)
    end
  end
end

function ExtensionMgr:UnregisterLocalNotify(viewName, name, handler, handlerObj)
  local views2Extends = self.views2Extends[viewName]
  if not views2Extends then
    return
  end
  local ENV = _ENV
  for i = 1, #views2Extends do
    local localDispatcher = self.dispatchers[views2Extends[i]]
    if not localDispatcher then
    else
      localDispatcher:RemoveListener(name, handler, handlerObj)
    end
  end
end

function ExtensionMgr:LocalNotify(viewName, name, ...)
  local views2Extends = self.views2Extends[viewName]
  if not views2Extends then
    return
  end
  local ENV = _ENV
  for i = 1, #views2Extends do
    local localDispatcher = self.dispatchers[views2Extends[i]]
    if not localDispatcher then
    else
      localDispatcher:Dispatch(name, ...)
    end
  end
end

function ExtensionMgr:ResetAllExtensions()
  for k, v in pairs(self.setting) do
    self:_ResetExtension(k)
  end
end

function ExtensionMgr:_BuildAllExtensions()
  for k, v in pairs(self.setting) do
    if not v.ID then
      v.ID = k
    end
    self:_InitExtension(k)
  end
end

function ExtensionMgr:_InitExtension(id)
  local extObj = self.setting[id]
  if not extObj then
    return
  end
  local extDispatcher = {}
  NotifyDispatcher.Extend(extDispatcher)
  self.dispatchers[id] = extDispatcher
  local len = 0
  local ENV = _ENV
  local models = extObj.models
  if models then
    len = #models
    for i = 1, len do
      if ENV[models[i]] then
        local model = rawget(ENV[models[i]], "Instance")
        if not model then
          model = ENV[models[i]]()
          rawset(ENV[models[i]], "Instance", model)
        end
        model:SetDispatcher(extDispatcher)
        model:OnInit()
      else
        Logger.Error("Cannot find model class:", models[i])
      end
    end
  end
  local controllers = extObj.controllers
  if controllers then
    len = #controllers
    for i = 1, len do
      if ENV[controllers[i]] then
        local controller = rawget(ENV[controllers[i]], "Instance")
        if not controller then
          controller = ENV[controllers[i]]()
          rawset(ENV[controllers[i]], "Instance", controller)
        end
        controller:SetDispatcher(extDispatcher)
        controller:OnInit()
      else
        Logger.Error("Cannot find controller class:", controllers[i])
      end
    end
  end
  local views = extObj.views
  if views then
    len = #views
    for i = 1, len do
      self.views2Extends[views[i]] = self.views2Extends[views[i]] or {}
      table.insert(self.views2Extends[views[i]], extObj.ID)
    end
  end
end

function ExtensionMgr:_ResetExtension(id)
  local extObj = self.setting[id]
  if not extObj then
    return
  end
  local len = 0
  local ENV = _ENV
  local models = extObj.models
  if models then
    len = #models
    for i = 1, len do
      local model = ENV[models[i]].Instance
      model:OnReset()
    end
  end
  local controllers = extObj.controllers
  if controllers then
    len = #controllers
    for i = 1, len do
      local controller = ENV[controllers[i]].Instance
      controller:OnReset()
    end
  end
end

ExtensionMgr.Instance = ExtensionMgr()
return ExtensionMgr
