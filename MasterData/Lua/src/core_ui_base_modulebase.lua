local moduleBase = class("moduleBase", G_UIBase)
local blendDefinitionType = typeof(C_BlendDefinition)
moduleBase.ModuleType = {
  Unknown = 0,
  Static = 1,
  Dynamic = 2,
  TableItem = 3
}

function moduleBase:ctor(moduleType)
  moduleBase.super.ctor(self)
  self._moduleType = moduleType or self.ModuleType.Unknown
end

function moduleBase:created(bindData, emitMethods, parent)
  if self.bind then
    self.bind = self.bind()
  end
  if self.methods then
    self.methods = self.methods()
  end
  self.emitMethods = emitMethods
  self.bind = self:mergeData(bindData, self.bind)
  self.parent = parent
  self:preBind(bindData)
  moduleBase.super.created(self)
end

function moduleBase:getModuleType()
  return self._moduleType
end

function moduleBase:emit(eventName, ...)
  if not self.isOpen then
    return
  end
  if self.emitMethods ~= nil and self.emitMethods[eventName] then
    self.emitMethods[eventName](self.parent, ...)
  end
end

function moduleBase:preBind()
end

function moduleBase:toBind(uiBinding)
  if self.isBind then
    return
  end
  L_ProfilerUtil.BeginSample("lua moduleBase tobind")
  moduleBase.super.toBind(self, uiBinding)
  self.gameObject = self.uiBinding.gameObject
  self._internal_blendDefinition = uiBinding.gameObject:TryGetComponent(blendDefinitionType)
  if self._internal_blendDefinition and self.parent then
    local moduleParent = self.parent
    while moduleParent and not moduleParent.csharpPage do
      moduleParent = moduleParent.parent
    end
    if moduleParent and moduleParent.csharpPage and moduleParent.csharpPage.transition and moduleParent.csharpPage.transition.blendDefinition then
      local parentBlendDefinition = moduleParent.csharpPage.transition.blendDefinition
      self._internal_blendDefinition:SetParentBlendDefinition(parentBlendDefinition)
      parentBlendDefinition:AddChildBlendDefinitionTime(self._internal_blendDefinition.gameObject:GetInstanceID(), true, self._internal_blendDefinition)
    end
  end
  if not self.isOpen then
    self.isOpen = true
    if self.bindComponents ~= nil then
      if self.bindComponents.UINavigationBinding ~= nil then
        local pageName = self:getModulePageName()
        if pageName ~= nil then
          self.bindComponents.UINavigationBinding.runtimePageName = pageName
          self.bindComponents.UINavigationBinding:OnModuleCreated()
        end
      end
      if self.bindComponents.UIInputActionBinding ~= nil then
        local pageName = self:getModulePageName()
        if pageName ~= nil then
          self.bindComponents.UIInputActionBinding.runtimePageName = pageName
          self.bindComponents.UIInputActionBinding:OnModuleCreated()
        end
      end
    end
    self:open()
    self:setup()
  end
  if not self.isShow and uiBinding.gameObject.activeSelf then
    self.isShow = true
    self:show()
  end
  self:refresh()
  L_ProfilerUtil.EndSample()
end

function moduleBase:getModulePageName()
  local parent = self.parent
  local pageName
  if parent ~= nil then
    pageName = parent.pageName
    if pageName == nil then
      pageName = parent.name
    end
  end
  while pageName == nil and parent ~= nil do
    parent = parent.parent
    if parent ~= nil then
      pageName = parent.pageName
      if pageName == nil then
        pageName = parent.name
      end
    end
  end
  return pageName
end

function moduleBase:unBind()
  if not self.isBind then
    return
  end
  if self.isShow then
    self.isShow = false
    self:hide()
  end
  if self.isOpen then
    self.isOpen = false
    self:close()
  end
  if self._internal_blendDefinition then
    self._internal_blendDefinition:Reset()
  end
  self._internal_blendDefinition = nil
  moduleBase.super.unBind(self)
end

function moduleBase:toBindToArray(uiBinding, meta)
  if self.isBind then
    return
  end
  if not meta then
    self:toBind(uiBinding)
    return
  end
  if uiBinding then
    self.uiBinding = uiBinding
  end
  meta:copyFromBind(self.bind)
  setmetatable(self.bind, meta)
  self.bindComponentsCache = {}
  if self.bindComponents == nil then
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
  end
  meta._childModules = meta._childModules or {}
  self.isBind = true
  self.gameObject = self.uiBinding.gameObject
  self._internal_blendDefinition = uiBinding.gameObject:TryGetComponent(typeof(C_BlendDefinition))
  self.modules = meta._childModules
  self:_processModules(self.updateParent, self)
  if not self.isOpen then
    self.isOpen = true
    self:openModules()
    self:open()
    for k, v in pairs(meta._bindDefaultValue) do
      if meta._values[k] == nil then
        self.bind[k] = v
      end
    end
    meta._bindDefaultValue = nil
  end
  if not self.isShow and uiBinding.gameObject.activeSelf then
    self.isShow = true
    self:showModules()
    self:show()
  end
  self:refreshModules()
  self:refresh()
  return meta
end

function moduleBase:unBindFromArray()
  if not self.isBind then
    return
  end
  if self.isShow then
    self.isShow = false
    self:hideModules()
    self:hide()
  end
  if self.isOpen then
    self.isOpen = false
    self:closeModules()
    self:close()
  end
  local meta = getmetatable(self.bind)
  setmetatable(self.bind, nil)
  if meta then
    meta:cloneToBind(self.bind)
  end
  self:_processModules(self.updateParent, nil)
  self.modules = nil
  self.bindComponentsCache = nil
  self.uiBinding = nil
  self.isBind = false
  self.gameObject = nil
  self._internal_blendDefinition = nil
  return meta
end

function moduleBase:updateParent(parent)
  self.parent = parent
end

function moduleBase:open()
  if self.gameObject.activeSelf and (self._moduleType == self.ModuleType.Static or self._moduleType == self.ModuleType.TableItem) then
    self:internalPlayAnimOpen()
  end
end

function moduleBase:close()
  if self._moduleType == self.ModuleType.Static then
    self:internalPlayAnimClose()
  end
end

function moduleBase:toShow()
  if self.isShow then
    return
  end
  self.isShow = true
  self:show()
  self:internalPlayAnimShow(true)
end

function moduleBase:toHide()
  if not self.isShow then
    return
  end
  self.isShow = false
  self:hide()
  self:internalPlayAnimHide()
end

function moduleBase:_getDeactivateHandler()
  if self._deactivateHandler == nil then
    function self._deactivateHandler()
      if self.uiBinding then
        local go = self.uiBinding.gameObject
        
        if go.activeSelf then
          go:SetActive(false)
        end
      end
    end
  end
  return self._deactivateHandler
end

function moduleBase:playTransition(transitionType)
  if not self._internal_blendDefinition then
    return
  end
  if transitionType == 0 then
    self:internalPlayAnimOpen(false)
  elseif transitionType == 1 then
    self:internalPlayAnimShow(false)
  elseif transitionType == 2 then
    self:internalPlayAnimHide(false)
  elseif transitionType == 3 then
    self:internalPlayAnimClose(false)
  end
end

function moduleBase:internalPlayAnimOpen(controlActive)
  if self._internal_blendDefinition then
    if controlActive then
      local go = self._internal_blendDefinition.gameObject
      if not go.activeSelf then
        go:SetActive(true)
      end
    end
    self._internal_blendDefinition:OpenReset()
    self._internal_blendDefinition:PlayOpen(nil)
  end
end

function moduleBase:internalPlayAnimClose(controlActive)
  if self._internal_blendDefinition then
    local cb
    if controlActive then
      cb = self:_getDeactivateHandler()
    end
    self._internal_blendDefinition:CloseReset()
    self._internal_blendDefinition:PlayClose(cb)
  end
end

function moduleBase:internalPlayAnimShow(controlActive)
  if self._internal_blendDefinition then
    if controlActive then
      local go = self._internal_blendDefinition.gameObject
      if not go.activeSelf then
        go:SetActive(true)
      end
    end
    self._internal_blendDefinition:ShowReset()
    self._internal_blendDefinition:PlayShow(nil)
  end
end

function moduleBase:internalPlayAnimHide(controlActive)
  if self._internal_blendDefinition then
    local cb
    if controlActive then
      cb = self:_getDeactivateHandler()
    end
    self._internal_blendDefinition:HideReset()
    self._internal_blendDefinition:PlayHide(cb)
  end
end

function moduleBase:SetActive(active, isTransition)
  if isTransition == nil then
    isTransition = true
  end
  if not self._internal_blendDefinition or not isTransition then
    L_CommonUtil.setObjActive(self.gameObject, active)
    return
  end
  if active then
    self:internalPlayAnimShow(true)
  else
    self:internalPlayAnimHide(true)
  end
end

function moduleBase:GetSourceLuaPageOptions(key)
  local uiBase = self
  while uiBase ~= nil and uiBase.parent do
    uiBase = uiBase.parent
  end
  if uiBase and type(uiBase) == "table" and uiBase.options then
    return uiBase.options[key]
  end
end

return moduleBase
