local uiBase = class("uiBase")
local tag = "uiBase"
local _instanceDict = setmetatable({}, table.weakMetatable)
local _aliveDict = setmetatable({}, table.weakMetatable)
uiBase._bindDataMetaClass = require("core.ui.base.bindDataMeta")
uiBase._unbindFinalizers = {}

function uiBase:ctor()
  self.gameObject = nil
  self.modules = {}
  self._timerDict = nil
  self._reddotDict = nil
  if IS_EDITOR or IS_DEV_BUILD then
    _instanceDict[self] = true
    _aliveDict[self] = true
  end
end

function uiBase:_wrapData()
  L_ProfilerUtil.BeginSample("lua uibase _wrapData")
  local mt = self._bindDataMetaClass.new(self)
  mt:setupBindings()
  self.bind = setmetatable(self.bind, mt)
  L_ProfilerUtil.EndSample()
  return self.bind
end

function uiBase:wrapBindValue()
  L_ProfilerUtil.BeginSample("uiBase:wrapBindValue")
  local bindValueDefs = self.uiBinding.bindValueDefs
  if bindValueDefs ~= nil then
    self.bindValue = self.bindValue or {}
    local length = bindValueDefs.Length
    local key, bindValue
    for i = 0, length - 1 do
      bindValue = bindValueDefs[i]
      if bindValue ~= nil then
        key = bindValue.bindName
        self.bindValue[key] = bindValue.value
      end
    end
  end
  L_ProfilerUtil.EndSample()
end

function uiBase._doOpenModule(md, options)
  if md.isBind and not md.isOpen then
    md.isOpen = true
    if md.openModules then
      md:openModules(options)
    end
    if md.open then
      md:open(options)
    end
  end
end

function uiBase._doOnTopChangeModules(md, options)
  if md.isBind then
    if md.onTopChangeModules then
      md:onTopChangeModules(options)
    end
    if md.onTopChange then
      md:onTopChange(options)
    end
  end
end

function uiBase._doCloseModule(md, options)
  if md.isBind and md.isOpen then
    if md.closeModules then
      md:closeModules(options)
    end
    if md.close then
      md:close(options)
    end
    md.isOpen = false
  end
end

function uiBase._doShowModule(md, options)
  if md.isBind and md.isOpen and not md.isShow then
    local go = md.uiBinding and md.uiBinding.gameObject
    if go and go.activeSelf then
      md.isShow = true
      if md.showModules then
        md:showModules(options)
      end
      if md.show then
        md:show(options)
      end
    end
  end
end

function uiBase._doHideModule(md, options)
  if md.isBind and md.isShow then
    if md.hideModules then
      md:hideModules(options)
    end
    if md.hide then
      md:hide(options)
    end
    md.isShow = false
  end
end

function uiBase._doDispose(md, options)
  if md._dispose then
    md:_dispose(options)
  end
end

function uiBase._doRefreshModule(md)
  if md.isBind and md.isOpen then
    if md.refreshModules then
      md:refreshModules()
    end
    if md.refresh then
      md:refresh()
    end
  end
end

function uiBase._doUnbindModule(md)
  if md.isBind then
    if md.unbindModules then
      md:unbindModules()
    end
    if md.unBind then
      md:_ensureUnbind()
    end
  end
end

function uiBase._doPlayTransition(md, transitionType)
  if md.isBind then
    if md.playTransitionModules then
      md:playTransitionModules(transitionType)
    end
    if md.playTransition then
      md:playTransition(transitionType)
    end
  end
end

function uiBase:_processModules(func, ...)
  if func == nil then
    return
  end
  if not self.modules then
    return
  end
  for _, mds in pairs(self.modules) do
    if type(mds) == "table" then
      if mds.class then
        func(mds, ...)
      else
        for _, md in pairs(mds) do
          if type(md) == "table" then
            func(md, ...)
          end
        end
      end
    end
  end
end

function uiBase._doRefreshTopBar(md)
  if md.isBind and md.isOpen and md.onTopBarRefresh then
    md:onTopBarRefresh()
  end
end

function uiBase:toBind(uiBinding)
  if self.isBind then
    return
  end
  L_ProfilerUtil.BeginSample("lua uibase tobind")
  if uiBinding then
    self.uiBinding = uiBinding
  end
  if self.uiBinding == nil then
    errorf("uiBinding is nil: " .. self.pageName)
  end
  self.labels = uiBinding.labels or {}
  self.uiBinding:RemoveAllBindings()
  self.uiBinding:RecoverSprite()
  self.bind = self.bind or {}
  self.methods = self.methods or {}
  self.modules = {}
  self:_wrapData()
  self:wrapBindValue()
  self.bindComponentsCache = {}
  self.bindComponents = setmetatable({}, {
    __index = function(t, k)
      local val = self.bindComponentsCache[k]
      if L_CommonUtil.isValid(val) then
        return val
      end
      if self.uiBinding == nil then
        return nil
      end
      local exist, val = self.uiBinding.BindComponentMap:TryGetValue(k)
      if exist then
        self.bindComponentsCache[k] = val
        return val
      else
        return nil
      end
    end
  })
  self.isBind = true
  L_ProfilerUtil.EndSample()
end

function uiBase:unBind()
  if not self.isBind then
    return
  end
  self:unbindModules()
  local meta = getmetatable(self.bind)
  setmetatable(self.bind, nil)
  if meta then
    if meta._values then
      for k, v in pairs(meta._values) do
        self.bind[k] = v
      end
    end
    if meta.dispose then
      meta:dispose()
    end
  end
  self.modules = nil
  self.linkerDataDict = nil
  self.bindComponents = nil
  self.bindComponentsCache = nil
  self.uiBinding = nil
  self.labels = nil
  for k, v in pairs(uiBase._unbindFinalizers) do
    v(self)
  end
  self.isBind = false
end

function uiBase:_ensureUnbind()
  self:unBind()
  if self.isBind then
    uiBase.unBind(self)
  end
end

function uiBase:reBind(uiBinding)
  self:_ensureUnbind()
  self:toBind(uiBinding)
end

function uiBase:setUIBinding(uiBinding)
  self.uiBinding = uiBinding
end

function uiBase:created()
  if self.uiBinding == nil then
    return
  end
  self:toBind(self.uiBinding)
end

function uiBase:mergeData(newData, defaultData)
  if newData == nil then
    return defaultData
  end
  if type(newData) == "table" then
    if defaultData ~= nil then
      for i, v in pairs(defaultData) do
        if newData[i] == nil then
          newData[i] = v
        end
      end
    end
  elseif type(newData) == "function" and defaultData ~= nil then
    local nd = newData()
    if type(defaultData) == "function" then
      function newData()
        return self:mergeData(nd, defaultData())
      end
    else
      function newData()
        return self:mergeData(nd, defaultData)
      end
    end
  end
  return newData
end

function uiBase:setup(options)
  local mt = getmetatable(self.bind)
  if mt then
    mt:setupValues()
  end
end

function uiBase:open(options)
end

function uiBase:close(options)
end

function uiBase:show(options)
end

function uiBase:hide(options)
end

function uiBase:onTopChange(options)
end

function uiBase:refresh()
end

function uiBase:_dispose(options)
  self:_processModules(self._doDispose, options)
  self:_ensureUnbind()
  for k, v in pairs(uiBase._unbindFinalizers) do
    v(self)
  end
  if self.destroy then
    self:destroy(options)
  end
  table.clear(self)
  _aliveDict[self] = nil
  self.isOpen = false
end

function uiBase:registerReddot(go, key)
  L_ReddotManager:registerReddot(go, key)
  self._reddotDict = self._reddotDict or {}
  self._reddotDict[key] = true
end

function uiBase:disposeReddot()
  if not self._reddotDict then
    return
  end
  for key, _ in pairs(self._reddotDict) do
    L_ReddotManager:unregisterReddotByKey(key)
  end
  table.clear(self._reddotDict)
end

function uiBase:onTopBarRefresh()
end

function uiBase:openModules(options)
  self:_processModules(self._doOpenModule, options)
end

function uiBase:onTopChangeModules(options)
  self:_processModules(self._doOnTopChangeModules, options)
end

function uiBase:closeModules(options)
  self:_processModules(self._doCloseModule, options)
end

function uiBase:showModules(options)
  self:_processModules(self._doShowModule, options)
end

function uiBase:hideModules(options)
  self:_processModules(self._doHideModule, options)
end

function uiBase:refreshModules()
  self:_processModules(self._doRefreshModule)
end

function uiBase:unbindModules()
  self:_processModules(self._doUnbindModule)
end

function uiBase:playTransitionModules(transitionType)
  self:_processModules(self._doPlayTransition, transitionType)
end

function uiBase:playAnimation(animName)
  self.uiBinding:PlayAnimation(animName)
end

function uiBase:stopAnimation(animName)
  self.uiBinding:StopAnimation(animName)
end

function uiBase:refreshTopBar()
  self:onTopBarRefresh()
  self:_processModules(self._doRefreshTopBar)
end

function uiBase:safeWrap(clauser)
  return function(...)
    if self.isBind then
      clauser(...)
    end
  end
end

function uiBase:countNumber(attributeType)
  if attributeType == nil then
    return nil
  end
  local result = attributeType - math.floor(attributeType / 10000) * 10000
  if result == 201 then
    result = 11
  end
  return result
end

function uiBase:newOrResetTimer(key, ...)
  self._timerDict = self._timerDict or {}
  local timer = self._timerDict[key]
  if not timer then
    timer = Timer.new(...)
  else
    timer:stop()
    timer:reset(...)
  end
  self._timerDict[key] = timer
  timer:start()
end

function uiBase:stopTimer(key)
  if not self._timerDict then
    return
  end
  local timer = self._timerDict[key]
  if timer then
    timer:destroy()
    self._timerDict[key] = nil
  end
end

function uiBase:getTimer(key)
  if self._timerDict then
    return self._timerDict[key]
  end
end

function uiBase:clearTimer()
  if not self._timerDict then
    return
  end
  for _, timer in pairs(self._timerDict) do
    timer:destroy()
    timer = nil
  end
  self._timerDict = nil
end

function uiBase._unbindFinalizers.event(inst)
  if inst._hasRegisteredEvent then
    for k, _ in pairs(inst._hasRegisteredEvent) do
      k:unRegisterAll(inst)
    end
    inst._hasRegisteredEvent = nil
  end
end

uiBase._unbindFinalizers.reddot = uiBase.disposeReddot
uiBase._unbindFinalizers.timer = uiBase.clearTimer

function uiBase._unbindFinalizers.shortCut(inst)
  if inst.pageName ~= nil and inst.pageName ~= "" and L_ShortCutManager then
    L_ShortCutManager:removeShortCut(inst.pageName)
  end
end

local function formatDebug(dict)
  local array = {}
  for k, v in pairs(dict) do
    table.insert(array, string.format("%s: %d", k, v))
  end
  table.sort(array)
  return table.concat(array, "\n")
end

function uiBase:printInstances(hideAlive)
  local dict = {}
  local dict2 = hideAlive or {}
  local total = 0
  for k, v in pairs(_instanceDict) do
    local name = k.__cname
    if _aliveDict[k] then
      if not hideAlive then
        local count = dict2[name] or 0
        dict2[name] = count + 1
      end
    else
      local count = dict[name] or 0
      dict[name] = count + 1
      total = total + 1
    end
  end
  local res = string.format("====== dead instances (%d) ======\n", total)
  res = res .. formatDebug(dict)
  if not hideAlive then
    res = res .. [[

====== alive instances ======
]]
    res = res .. formatDebug(dict2)
  end
  return res
end

return uiBase
