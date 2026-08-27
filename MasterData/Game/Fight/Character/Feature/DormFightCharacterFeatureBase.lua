local DormFightCharacterFeatureBase = class("DormFightCharacterFeatureBase")

function DormFightCharacterFeatureBase:ctor()
  self._owner = nil
end

function DormFightCharacterFeatureBase:GetFeature(featureType)
  return self._owner and self._owner:GetFeature(featureType)
end

function DormFightCharacterFeatureBase:Init(owner)
  self._owner = owner
  self:OnInit()
end

function DormFightCharacterFeatureBase:Update(deltaTime)
  self:OnUpdate(deltaTime)
end

function DormFightCharacterFeatureBase:Destroy()
  self:OnDestroy()
end

function DormFightCharacterFeatureBase:OnInit()
end

function DormFightCharacterFeatureBase:OnUpdate(deltaTime)
end

function DormFightCharacterFeatureBase:Destroy()
end

return DormFightCharacterFeatureBase
