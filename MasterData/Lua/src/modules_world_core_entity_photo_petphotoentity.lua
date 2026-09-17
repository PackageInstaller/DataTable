local this = class("petPhotoEntity", require(L_EcsConst.aliveType.default))
local CapsuleCollider = CS.UnityEngine.CapsuleCollider
local _NormalFaceIdx = 1

function this:initialize(petEntityData)
  this.super.initialize(self, petEntityData)
  self.uiNodeGo = nil
  self.stateComponent = self:getStateComponent(true)
  self.modelControlComponent = self:getModelControlComponent(true)
  self:init_collider()
  self:add3DUINode()
end

function this:reset()
  self.stateComponent:reset()
end

function this:onDestroy()
  self:remove_triggerEvent()
  if self.uiNodeGo then
    C_GameObject.Destroy(self.uiNodeGo)
    self.uiNodeGo = nil
  end
  self.modelCollider = nil
  self.childColliders = nil
  if self.expression then
    self:playExpression(_NormalFaceIdx)
    self.expression = nil
  end
  if self.stateComponent then
    self.stateComponent:onDestroy()
  end
  this.super.onDestroy(self)
end

function this:init_collider()
  self.modelCollider = self.gameObject:GetComponent(typeof(CapsuleCollider))
  self.childColliders = self.gameObject:GetComponentsInChildren(typeof(CapsuleCollider))
  self:setColliderIsTrigger(true)
end

function this:setColliderIsTrigger(bool)
  if not self.childColliders then
    return
  end
  for i = 0, self.childColliders.Length - 1 do
    self.childColliders[i].isTrigger = bool
  end
end

function this:addTriggerEnter(callback, register)
  self.modelControlComponent:addTriggerEnter(callback, register)
end

function this:removeTriggerEnter(callback, register)
  self.modelControlComponent:removeTriggerEnter(callback, register)
end

function this:addTriggerExit(callback, register)
  self.modelControlComponent:addTriggerExit(callback, register)
end

function this:removeTriggerExit(callback, register)
  self.modelControlComponent:removeTriggerExit(callback, register)
end

function this:init_triggerEvent()
  self:addTriggerEnter(self.on_triggerEnter, self)
  self:addTriggerExit(self.on_triggerExit, self)
  self.blockDict = {}
  self.checkLayer = 2 << L_Const.layer.default - 1
end

function this:remove_triggerEvent()
  self:removeTriggerEnter(self.on_triggerEnter, self)
  self:removeTriggerExit(self.on_triggerExit, self)
end

function this:__CheckIsBlock(collider)
  local isBlock
  if L_CommonUtil.compareLayer(collider, L_Const.layer.character) then
    isBlock = true
  else
    local entityTrans = self:getTransform()
    local entityPos = entityTrans.position
    local distance = self.modelCollider.radius
    isBlock = C_Physics.CheckBox(entityPos, C_Vector3(distance, distance * 0.5, distance))
  end
  return isBlock
end

function this:on_triggerEnter(collider)
  if self:__CheckIsBlock(collider) then
    local id = collider:GetInstanceID()
    self.blockDict[id] = true
  end
end

function this:on_triggerExit(collider)
  local id = collider:GetInstanceID()
  if self.blockDict[id] then
    self.blockDict[id] = nil
  end
end

function this:canSet()
  return table.count(self.blockDict) <= 0
end

function this:add3DUINode()
  local trs = self:getTransform()
  if trs then
    if self.uiNodeGo then
      C_GameObject.Destroy(self.uiNodeGo)
      self.uiNodeGo = nil
    end
    local go = L_ResPool:syncGameObject("UI/Pages/Photo/petPos3D.prefab")
    self.uiNodeGo = go
    self.uiNodeTrs = go.transform
    self.uiNodeTrs:SetParent(trs)
    self.petposImg = self.uiNodeTrs:Find("petPos"):GetComponent(typeof(C_LImage))
    local width = 75 * self.modelCollider.radius
    L_Vector3.setUISize(self.petposImg.transform, L_Vector3.getTemp(width, width))
  end
end

function this:activeUINode(isShow)
  if self.uiNodeGo then
    self.uiNodeGo:ActiveTrans(isShow)
  end
end

function this:setPetPosImgColor(color)
  if self.curColor == color then
    return
  end
  if not color or self.petposImg:IsNull() then
    return
  end
  self.curColor = color
  self.petposImg.color = color
end

function this:checkIsOnGround()
  if self.csEntity then
    return self.csEntity.entity:CheckIsOnGround()
  end
end

function this:IsInWater()
  if self.csEntity then
    return self.csEntity.entity:IsInWater()
  end
end

function this:playExpression(index)
  if not self.expression then
    self.expression = self.modelControl:GetComponentByType(typeof(CS.KiboExpression))
    if not self.expression then
      error("奇波缺少KiboExpression组件")
      return
    end
  end
  self.expression.LockExpression = false
  self.expression:SetEye(index)
  self.expression:SetMouth(index)
  if index ~= _NormalFaceIdx then
    self.expression.LockExpression = true
  end
end

return this
