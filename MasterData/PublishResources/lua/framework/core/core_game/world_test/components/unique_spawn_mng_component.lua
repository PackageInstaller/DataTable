_class("SpawnMngComponent", Object)

function SpawnMngComponent:Constructor(world, mng)
  self.Manager = mng
end

function BaseWorld:SpawnMng()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.SpawnMng)
end

function BaseWorld:AddSpawnMng(mng)
  local index = self.BW_UniqueComponentsEnum.SpawnMng
  local component = SpawnMngComponent:New(self, mng)
  self:SetUniqueComponent(index, component)
  return component
end
