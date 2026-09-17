local this = class("partBase")
local _bindDataMetaClass = require("core.ui.base.bindDataMeta")

function this:ctor()
  self.gameObject = nil
end

function this:created(obj, options)
  self.gameObject = obj
  local uiBinding = obj:TryGetComponent(typeof(C_UIBinding))
  self:setUIBinding(uiBinding)
  self.bind = self.bind() or {}
  self.methods = self.methods() or {}
  self:preBind()
  self:toBind(self.uiBinding)
  self:open(options)
end

function this:destroy()
  self:unBind()
  self:close()
  self.uiBinding = nil
  self.gameObject = nil
end

function this:preBind()
end

function this:open(options)
end

function this:close(options)
end

function this:toBind(uiBinding)
  if self.isBind then
    return
  end
  self.labels = uiBinding.labels or {}
  uiBinding:RemoveAllBindings()
  uiBinding:RecoverSprite()
  self:_wrapData()
  self.bindComponents = {}
  if uiBinding.BindComponentMap then
    for k, v in pairs(uiBinding.BindComponentMap) do
      self.bindComponents[k] = v
    end
  end
  self.isBind = true
end

function this:unBind()
  if not self.isBind then
    return
  end
  local meta = getmetatable(self.bind)
  setmetatable(self.bind, nil)
  if meta._values then
    for k, v in pairs(meta._values) do
      self.bind[k] = v
    end
  end
  table.clear(self.bindComponents)
  self.uiBinding:RemoveAllBindings()
  if self._hasRegisteredEvent then
    for k, _ in pairs(self._hasRegisteredEvent) do
      k:unRegisterAll(self)
    end
    self._hasRegisteredEvent = nil
  end
  self.isBind = false
end

function this:setUIBinding(uiBinding)
  self.uiBinding = uiBinding
end

function this:reBind(uiBinding)
  self:unBind()
  self:toBind(uiBinding)
end

function this:_wrapData()
  local mt = _bindDataMetaClass.new(self)
  mt:setupBindings()
  self.bind.mt = mt
  self.bind = setmetatable(self.bind, mt)
  return self.bind
end

function this:playAnimation(animName)
  self.uiBinding:PlayAnimation(animName)
end

function this:stopAnimation(animName)
  self.uiBinding:StopAnimation(animName)
end

function this:countNumber(attributeType)
  if attributeType == nil then
    return nil
  end
  local result = attributeType - math.floor(attributeType / 10000) * 10000
  if result == 201 then
    result = 11
  end
  return result
end

return this
