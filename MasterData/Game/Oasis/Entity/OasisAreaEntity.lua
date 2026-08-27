local OasisAreaEntity = class("OasisAreaEntity")

function OasisAreaEntity:ctor(gameObject)
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(gameObject, self.bind)
end

function OasisAreaEntity:InitOasisAreaEntity(areaId)
  self.areaId = areaId
end

function OasisAreaEntity:GetOasisAreaEntityId()
  return self.areaId
end

function OasisAreaEntity:OnDelete()
  DestroyUnityObject(self.gameObject)
end

return OasisAreaEntity
