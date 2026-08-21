_class("BulletTimeComponent", Object)
BulletTimeComponent = BulletTimeComponent

function BulletTimeComponent:Constructor()
  self._enableBulletTime = false
  self._entityIDList = {}
end

function BulletTimeComponent:IsEnableBullteTime()
  return self._enableBulletTime
end

function BulletTimeComponent:SetEnableBullteTime(enable)
  self._enableBulletTime = enable
end

function BulletTimeComponent:GetBulletTimeEntityIDList()
  return self._entityIDList
end

function BulletTimeComponent:AddBulletTimeEntityID(entityID)
  self._entityIDList[#self._entityIDList + 1] = entityID
end

function BulletTimeComponent:ResetBulletTimeData()
  self._enableBulletTime = false
  self._entityIDList = {}
end

function BulletTimeComponent:WEC_PostInitialize(owner)
end

function BulletTimeComponent:WEC_PostRemoved()
end

function Entity:BulletTime()
  return self:GetComponent(self.WEComponentsEnum.BulletTime)
end

function Entity:HasBulletTime()
  return self:HasComponent(self.WEComponentsEnum.BulletTime)
end

function Entity:AddBulletTime()
  local index = self.WEComponentsEnum.BulletTime
  local component = BulletTimeComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceBulletTime(isEnalbeBulletTime)
  local index = self.WEComponentsEnum.BulletTime
  local component = self:BulletTime()
  component:SetEnableBullteTime(isEnalbeBulletTime)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveBulletTime()
  if self:HasBulletTime() then
    self:RemoveComponent(self.WEComponentsEnum.BulletTime)
  end
end
