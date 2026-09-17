local cls = class("uiSubModuleManager")

function cls:ctor()
end

function cls:init()
  self.modules = {}
  self.state = {}
  self.updateFunc = {}
end

function cls:initSubModules(parent, state)
  self.parent = parent
  self.curState = state
end

function cls:addSubModules(state, uiName, parent, ...)
  if not self.state then
    self.state = {}
  end
  if not self.state[state] then
    self.state[state] = {}
  end
  table.insert(self.state[state], {
    ui_name = uiName,
    ui_parent = parent,
    ui_params = table.pack(...)
  })
end

function cls:openSubModulesByIndex(index, callback)
  if self.curState == index then
    if callback then
      callback()
    end
    return
  end
  local lastModules = self:getSubModulesByIndex(self.curState)
  self.curState = index
  local nowModules = self:getSubModulesByIndex(index)
  for _, uiInfo1 in ipairs(lastModules) do
    local needClose = true
    for _, uiInfo2 in ipairs(nowModules) do
      if uiInfo1.ui_name == uiInfo2.ui_name then
        needClose = false
        break
      end
    end
    if needClose then
      self:closeSubModule(uiInfo1.ui_name)
    end
  end
  for _, uiInfo1 in ipairs(nowModules) do
    local needOpen = true
    for _, uiInfo2 in ipairs(lastModules) do
      if uiInfo1.ui_name == uiInfo2.ui_name then
        needOpen = false
        self:refreshSubModule(uiInfo1.ui_name, index)
        break
      end
    end
    if needOpen then
      self:openSubModule(uiInfo1.ui_name, uiInfo1.ui_parent, uiInfo1.ui_params, callback)
    end
  end
end

function cls:closeSubModulesByIndex(index)
  local modules = self:getSubModulesByIndex(index)
  for _, uiInfo in ipairs(modules) do
    self:closeSubModule(uiInfo.ui_name)
  end
end

function cls:getSubModulesByIndex(index)
  local modules = {}
  for k, v in pairs(self.state) do
    if 0 < k & index then
      for _, v1 in ipairs(v) do
        table.insert(modules, v1)
      end
    end
  end
  return modules
end

function cls:getSubModule(ui_name)
  local target = self.modules[ui_name]
  return target
end

function cls:openSubModule(uiName, parent, uiParams, callback)
  local target = self:getSubModule(uiName)
  if target and L_CommonUtil.isValid(target.pfObj) then
    target.isActive = true
    L_CommonUtil.setObjActive(target.pfObj, true)
    target.script:activate(table.unpack(uiParams))
    local moduleCfg = C_UIMgr.luaMiddleware:GetSubModuleConfig(uiName)
    if math.isEmpty(moduleCfg.uiName) then
      errorf("not SubModuleConfigUiName: " .. uiName)
    end
    if moduleCfg.update then
      self.updateFunc[uiName] = target.script
    end
    return
  end
  local target = self:getSubModule(uiName)
  if not target then
    self.modules[uiName] = {}
  end
  self.modules[uiName].isActive = true
  self:loadChildPrefabAsync(uiName, parent, uiParams, callback)
end

function cls:refreshSubModule(ui_name, newState)
  local target = self:getSubModule(ui_name)
  if not target or not target.script then
    return
  end
  if target.script.switchState then
    target.script:switchState(newState)
  end
end

function cls:closeSubModule(ui_name)
  local target = self:getSubModule(ui_name)
  if not target then
    return
  end
  if L_CommonUtil.isValid(target.pfObj) then
    L_CommonUtil.setObjActive(target.pfObj, false)
    target.script:deActivate()
    local moduleCfg = C_UIMgr.luaMiddleware:GetSubModuleConfig(ui_name)
    if math.isEmpty(moduleCfg.uiName) then
      errorf("not SubModuleConfigUiName: " .. ui_name)
    end
    if moduleCfg.update then
      self.updateFunc[ui_name] = nil
    end
  end
  target.isActive = false
end

function cls:loadChildPrefabAsync(uiName, parent, uiParams, callback)
  if self.modules[uiName].isLoading then
    return
  end
  local moduleCfg = C_UIMgr.luaMiddleware:GetSubModuleConfig(uiName)
  if math.isEmpty(moduleCfg.uiName) then
    errorf("not SubModuleConfigUiName: " .. uiName)
    return
  end
  self.modules[uiName].isLoading = true
  if C_UIMgr.isAsyncInstantiate then
    C_UIMgr.uiLoader:SpawnAsync(moduleCfg.pfPath, function(instanceId, go)
      if not L_CommonUtil.isValid(go) then
        errorf("cant load asset from " .. moduleCfg.pfPath)
        return
      end
      if not self.modules or not self.modules[uiName] then
        C_PrefabManager:RecycleByLoader(go)
        return
      end
      self.modules[uiName].pfObj = go
      local script = require(moduleCfg.scriptPath).new(G_UIModuleBase.ModuleType.Static)
      self.modules[uiName].script = script
      script:created(nil, nil, self.parent)
      script:toBind(go:GetComponent(typeof(C_UIBinding)))
      if not self.modules[uiName].isActive then
        L_CommonUtil.setObjActive(go, false)
        script:deActivate()
        if moduleCfg.update then
          self.updateFunc[uiName] = nil
        end
        return
      end
      L_CommonUtil.setObjActive(go, true)
      script:deActivate()
      script:activate(table.unpack(uiParams))
      if moduleCfg.update then
        self.updateFunc[uiName] = script
      end
      if callback ~= nil then
        callback(nil)
      end
    end, parent, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  else
    C_UIMgr.uiLoader:SpawnAsync(moduleCfg.pfPath, function(instanceId, go)
      if not L_CommonUtil.isValid(go) then
        errorf("cant load asset from " .. moduleCfg.pfPath)
        return
      end
      if not self.modules or not self.modules[uiName] then
        C_PrefabManager:RecycleByLoader(go)
        return
      end
      self.modules[uiName].pfObj = go
      local script = require(moduleCfg.scriptPath).new(G_UIModuleBase.ModuleType.Static)
      self.modules[uiName].script = script
      script:created(nil, nil, self.parent)
      script:toBind(go:GetComponent(typeof(C_UIBinding)))
      if not self.modules[uiName].isActive then
        L_CommonUtil.setObjActive(go, false)
        script:deActivate()
        if moduleCfg.update then
          self.updateFunc[uiName] = nil
        end
        return
      end
      L_CommonUtil.setObjActive(go, true)
      script:deActivate()
      script:activate(table.unpack(uiParams))
      if moduleCfg.update then
        self.updateFunc[uiName] = script
      end
      if callback ~= nil then
        callback(nil)
      end
    end, parent, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page), false, true)
  end
end

function cls:closeAllSubModules()
  if not self.modules then
    return
  end
  for uiName, v in pairs(self.modules) do
    self:closeSubModule(uiName)
  end
  self.curState = 0
end

function cls:destroyAllSubModules()
  if not self.modules then
    return
  end
  for _, v in pairs(self.modules) do
    if v.script then
      v.script:_ensureUnbind()
      v.script:_dispose()
      if v._dispose then
        v._dispose()
      end
    end
    C_PrefabManager:RecycleByLoader(v.pfObj)
  end
  self.modules = nil
  self.curState = 0
end

function cls:show(options)
  if not self.modules then
    return
  end
  for uiName, v in pairs(self.modules) do
    if v.script and v.isActive then
      v.script:show(options)
      v.script:showModules(options)
    end
  end
end

function cls:hide()
  if not self.modules then
    return
  end
  for uiName, v in pairs(self.modules) do
    if v.script and v.isActive then
      v.script:hide()
      v.script:hideModules()
    end
  end
end

function cls:update()
  for _, script in pairs(self.updateFunc) do
    script:update()
  end
end

return cls
