local FmtPlatformEntity = class("FmtPlatformEntity")
local CS_EventTriggerListener = CS.EventTriggerListener

function FmtPlatformEntity:InitFmtPlatEntity(go, fmtIndex, sceneCtrl, clickFunc, isBench, unlock)
  self.gameObject = go
  self.transform = go.transform
  self.fmtIndex = fmtIndex
  self.sceneCtrl = sceneCtrl
  self.collider = go:FindComponent(eUnityComponentID.Collider)
  self.mesh = go:FindComponent(eUnityComponentID.MeshRenderer)
  self.clickFunc = clickFunc
  self.isBench = isBench
  self.unlock = unlock
  self:ShowFmtPlatform(true)
  local eventTrigger = CS_EventTriggerListener.Get(self.gameObject)
  eventTrigger:onClick("+", BindCallback(self, self.OnClick))
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
end

function FmtPlatformEntity:GetFmtIndex()
  return self.fmtIndex
end

function FmtPlatformEntity:OnClick(go, eventData)
  if not self.unlock then
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.fmtIndex)
  end
end

function FmtPlatformEntity:ShowFmtPlatform(show)
  if self.isBench then
    show = false
  end
  self.mesh.enabled = show
end

function FmtPlatformEntity:IsFmtPlatformUnlock()
  return self.unlock
end

function FmtPlatformEntity:SetFmtPlatformDragEvent(beginDragFunc, dragFunc, endDragFunc)
  self.beginDragFunc = beginDragFunc
  self.dragFunc = dragFunc
  self.endDragFunc = endDragFunc
end

function FmtPlatformEntity:OnBeginDrag(go, eventData)
  if self.beginDragFunc ~= nil then
    self.beginDragFunc(self, eventData)
  end
end

function FmtPlatformEntity:OnDrag(go, eventData)
  if self.dragFunc ~= nil then
    self.dragFunc(self, eventData)
  end
end

function FmtPlatformEntity:OnEndDrag(go, eventData)
  if self.endDragFunc ~= nil then
    self.endDragFunc(self, eventData)
  end
end

function FmtPlatformEntity:EnableFmtPlatformRaycast(enable)
  self.collider.enabled = enable
end

function FmtPlatformEntity:OnDelete()
  DestroyUnityObject(self.gameObject)
end

return FmtPlatformEntity
