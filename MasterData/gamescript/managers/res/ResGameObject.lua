local TransformUtil = CS.Framework.TransformUtil
local _SetLocalPos = TransformUtil.SetLocalPos
local _SetPos = TransformUtil.SetPos
local _SetLocalEulerAngles = TransformUtil.SetLocalEulerAngles
local _SetLocalScale = TransformUtil.SetLocalScale
local _SetSortingOrderInChildren = CS.AMTimeline.AMTimelineUtils.SetSortingOrderInChildren
local _SetSortingLayerInChildren = CS.AMTimeline.AMTimelineUtils.SetSortingLayerInChildren
local _ComputeEffectLifeTime = CS.AMTimeline.AMTimelineUtils.ComputeEffectLifeTime
local _EnableRenderers = CS.AMTimeline.AMTimelineUtils.EnableRenderers
local _PauseEffects = CS.AMTimeline.AMTimelineUtils.PauseEffects
local _ResumeEffects = CS.AMTimeline.AMTimelineUtils.ResumeEffects
local _SetLayerRecursively = CS.AMTimeline.AMTimelineUtils.SetLayerRecursively
local ResGameObject = NewClass("ResGameObject")

function ResGameObject:ctor()
  self:Reset()
end

function ResGameObject:Reset()
  self.handleId = nil
  self.assetPath = nil
  self.gameObject = nil
  self.parent = nil
  self.worldPositionStays = false
  self.posX = nil
  self.posY = nil
  self.posZ = nil
  self.localPosX = nil
  self.localPosY = nil
  self.localPosZ = nil
  self.localEulerAnglesX = nil
  self.localEulerAnglesY = nil
  self.localEulerAnglesZ = nil
  self.scale = nil
  self.scaleX = nil
  self.scaleY = nil
  self.scaleZ = nil
  self.sortingOrder = nil
  self.sortingLayer = nil
  self.liftTime = nil
  self.time = nil
  self.timeCount = nil
  self.isLooping = nil
  self.isVisible = true
  self.isActive = true
  self.layer = nil
  self.finishHandler = nil
  self.loadedHandler = nil
  self.isPause = nil
end

function ResGameObject:IsValid()
  return self.handleId ~= nil
end

function ResGameObject:SetParent(parent, worldPositionStays)
  self.parent = parent
  self.worldPositionStays = worldPositionStays
  if not IsNil(self.gameObject) and self.gameObject.transform.parent ~= parent then
    self.gameObject.transform:SetParent(parent, worldPositionStays or false)
  end
end

function ResGameObject:SetLocalPos(lx, ly, lz)
  self.localPosX = lx or 0
  self.localPosY = ly or 0
  self.localPosZ = lz or 0
  if not IsNil(self.gameObject) then
    _SetLocalPos(self.gameObject.transform, self.localPosX, self.localPosY, self.localPosZ)
  end
end

function ResGameObject:SetPos(x, y, z)
  self.posX = x or 0
  self.posY = y or 0
  self.posZ = z or 0
  if not IsNil(self.gameObject) then
    _SetPos(self.gameObject.transform, self.posX, self.posY, self.posZ)
  end
end

function ResGameObject:SetLocalEulerAngle(eulerX, eulerY, eulerZ)
  self.localEulerAnglesX = eulerX or 0
  self.localEulerAnglesY = eulerY or 0
  self.localEulerAnglesZ = eulerZ or 0
  if not IsNil(self.gameObject) then
    _SetLocalEulerAngles(self.gameObject.transform, self.localEulerAnglesX, self.localEulerAnglesY, self.localEulerAnglesZ)
  end
end

function ResGameObject:SetScale(scale)
  self.scale = scale
  if not IsNil(self.gameObject) then
    _SetLocalScale(self.gameObject.transform, self.scale, self.scale, self.scale)
  end
end

function ResGameObject:SetScaleXYZ(scaleX, scaleY, scaleZ)
  self.scaleX = scaleX or 1
  self.scaleY = scaleY or 1
  self.scaleZ = scaleZ or 1
  if not IsNil(self.gameObject) then
    _SetLocalScale(self.gameObject.transform, self.scaleX, self.scaleY, self.scaleZ)
  end
end

function ResGameObject:SetSortingOrder(sortingOrder)
  if sortingOrder ~= self.sortingOrder then
    self.sortingOrder = sortingOrder
    if not IsNil(self.gameObject) then
      _SetSortingOrderInChildren(self.gameObject, self.sortingOrder)
    end
  end
end

function ResGameObject:SetSortingLayer(sortingLayer)
  if sortingLayer ~= self.sortingLayer then
    self.sortingLayer = sortingLayer
    if not IsNil(self.gameObject) then
      _SetSortingLayerInChildren(self.gameObject, self.sortingLayer)
    end
  end
end

function ResGameObject:SetLifeTime(liftTime)
  self.liftTime = liftTime
  if not IsNil(self.gameObject) then
    self:_CalcualteLiftTime()
  end
end

function ResGameObject:_CalcualteLiftTime()
  if not self.isLooping then
    self.time = self:GetLiftTime()
    if not self.time then
      self.time = _ComputeEffectLifeTime(self.gameObject)
    end
    if not self.time or self.time <= 0 then
      self.time = 3
    end
  else
    self.time = -1
  end
  if self.time > 0 then
    self.timeCount = 0
  else
    self.timeCount = nil
  end
end

function ResGameObject:SetVisible(visible, force)
  if self.isVisible == visible and not force then
    return
  end
  self.isVisible = visible
  if not IsNil(self.gameObject) then
    _EnableRenderers(self.gameObject, visible)
  end
end

function ResGameObject:SetActive(active)
  self.isActive = active
  if not IsNil(self.gameObject) and self.gameObject.activeSelf ~= active then
    self.gameObject:SetActive(active)
  end
end

function ResGameObject:Pause()
  if self.isPause then
    return
  end
  self.isPause = true
  if not IsNil(self.gameObject) then
    _PauseEffects(self.gameObject)
  end
end

function ResGameObject:Resume()
  if not self.isPause then
    return
  end
  self.isPause = nil
  if not IsNil(self.gameObject) then
    _ResumeEffects(self.gameObject)
  end
end

function ResGameObject:SetLayer(layer)
  self.layer = layer
  if self.layer and not IsNil(self.gameObject) then
    _SetLayerRecursively(self.gameObject, self.layer)
  end
end

function ResGameObject:OnEnable()
  self:_CalcualteLiftTime()
  self:SetVisible(self._visible, true)
  if self.layer then
    _SetLayerRecursively(self.gameObject, self.layer)
  end
  if self.sortingLayer then
    _SetSortingLayerInChildren(self.gameObject, self.sortingLayer)
  end
  if self.sortingOrder then
    _SetSortingOrderInChildren(self.gameObject, self.sortingOrder)
  end
  if self.isPause then
    _PauseEffects(self.gameObject)
  end
  if self.parent and self.parent ~= self.gameObject.transform.parent then
    self.gameObject.transform:SetParent(self.parent, self.worldPositionStays or false)
  end
  if self.scale then
    self:SetScale(self.scale)
  end
  if self.localPosX or self.localPosY or self.localPosZ then
    _SetLocalPos(self.gameObject.transform, self.localPosX or 0, self.localPosY or 0, self.localPosZ or 0)
  end
  if self.scaleX or self.scaleY or self.scaleZ then
    _SetLocalScale(self.gameObject.transform, self.scaleX or 1, self.scaleY or 1, self.scaleZ or 1)
  end
  if self.localEulerAnglesX or self.localEulerAnglesY or self.localEulerAnglesZ then
    _SetLocalEulerAngles(self.gameObject.transform, self.localEulerAnglesX or 0, self.localEulerAnglesY or 0, self.localEulerAnglesZ or 0)
  end
end

function ResGameObject:Update(deltaTime)
  if not self.isPause and self.timeCount and self.timeCount < self.time then
    self.timeCount = self.timeCount + deltaTime
    if self.timeCount >= self.time then
      self.timeCount = nil
      self:OnPlayedFinish()
    end
  end
end

function ResGameObject:OnDisable()
  self:SetScale(1)
  self.sortingOrder = nil
  self.sortingLayer = nil
  if self.isPause and not IsNil(self.gameObject) then
    _ResumeEffects(self.gameObject)
  end
  self.assetPath = nil
  self.layer = nil
  self.isPause = nil
  self.loadedHandler = nil
  self.handleId = nil
  self.gameObject = nil
  self.parent = nil
  self:Reset()
end

function ResGameObject:GetLiftTime()
  if self.liftTime and self.liftTime > 0 then
    return self.liftTime
  end
end

function ResGameObject:OnPlayedFinish()
  if self.finishHandler then
    self.finishHandler(self)
  end
end

return ResGameObject
