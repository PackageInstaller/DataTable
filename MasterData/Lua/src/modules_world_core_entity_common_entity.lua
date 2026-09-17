local this = class("entity", L_EcsConst.alive)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.csEntity = nil
  self.entityData = nil
end

function this:bindCsEntity(cEntity)
  assert(cEntity, L_WordsTpl:getValue("residual_code_entity_01"))
  self.csEntity = cEntity
  if cEntity.model then
    self.goModel = cEntity.model.gameObject
    self.modelControl = self.goModel:GetComponent(typeof(C_ModelControl))
  end
  if cEntity and cEntity.data then
    self.entityId = cEntity.data.entityId
  end
  self:bindGameObject(self.csEntity.entity.transform.gameObject)
end

function this:initialize(data)
end

function this:getUnitId()
  return -1
end

function this:reset()
end

function this:onDestroy()
  this.super.onDestroy(self)
  self.csEntity = nil
  self.agent = nil
  self.modelControl = nil
end

function this:setPosition(pos)
  self.csEntity.entity:SafeSetPosition(pos)
end

function this:SafeSetPosition(pos)
  self.csEntity.entity:SafeSetPosition(pos)
end

function this:setGroundPosition(pos)
  self.csEntity.entity:SetPosition(pos)
end

function this:setRotation(rot)
  self.csEntity.entity:SetAngles(rot)
end

function this:setLogicRotation(rotV3)
  if self.csEntity and self.csEntity.entity then
    C_GameUtil.SetAliveEntityAngle(self.csEntity, rotV3)
  end
end

function this:setSize(size)
  self.csEntity.entity:SetSize(size)
end

function this:getAnimatorComponent(isCreate)
  return self:getComponent(L_EcsConst.componentType.animator, isCreate)
end

function this:getStateComponent(isCreate)
  return self:getComponent(L_EcsConst.componentType.state, isCreate)
end

function this:getModelControlComponent(isCreate)
  return self:getComponent(L_EcsConst.componentType.modelControl, isCreate)
end

function this:getIkComponent(isCreate)
  return self:getComponent(L_EcsConst.componentType.ikComponent, isCreate)
end

return this
