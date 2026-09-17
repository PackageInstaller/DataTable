local this = class("modelControlComponent", L_EcsConst.component)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.triggerEnter = L_CommonUtil.handle(self.onTriggerEnter, self)
  self.triggerExit = L_CommonUtil.handle(self.onTriggerExit, self)
  self.triggerEnterList = nil
  self.triggerExitList = nil
end

function this:onBindGameObject(go)
  self.modelControl = self.parent.csEntity.entity.model.gameObject:GetComponent(typeof(C_ModelControl))
end

function this:onRemove()
  self.modelControl:RemoveTriggerEnterHandler(self.triggerEnter)
  self.modelControl:RemoveTriggerExitHandler(self.triggerExit)
end

function this:onDestroy()
end

function this:addTriggerEnter(callback, register)
  local call = {callback, register}
  if self.triggerEnterList then
    table.insert(self.triggerEnterList, call)
  else
    self.triggerEnterList = {call}
    self.modelControl:AddTriggerEnterHandler(nil, self.triggerEnter)
  end
end

function this:removeTriggerEnter(callback, register)
  if not self.triggerEnterList then
    return
  end
  table.removeWith(self.triggerEnterList, function(o)
    if register then
      return o[1] == callback and o[2] == register
    else
      return o[1] == callback
    end
  end)
end

function this:addTriggerExit(callback, register)
  local call = {callback, register}
  if self.triggerExitList then
    table.insert(self.triggerExitList, call)
  else
    self.triggerExitList = {call}
    self.modelControl:AddTriggerExitHandler(nil, self.triggerExit)
  end
end

function this:removeTriggerExit(callback, register)
  if not self.triggerExitList then
    return
  end
  table.removeWith(self.triggerExitList, function(o)
    if register then
      return o[1] == callback and o[2] == register
    else
      return o[1] == callback
    end
  end)
end

function this:onTriggerEnter(collider)
  for _, v in ipairs(self.triggerEnterList) do
    v[1](v[2], collider)
  end
end

function this:onTriggerExit(collider)
  for _, v in ipairs(self.triggerExitList) do
    v[1](v[2], collider)
  end
end

return this
