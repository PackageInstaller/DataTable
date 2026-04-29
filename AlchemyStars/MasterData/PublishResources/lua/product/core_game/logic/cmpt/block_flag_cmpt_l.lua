_class("BlockFlagComponent", Object)
BlockFlagComponent = BlockFlagComponent

function BlockFlagComponent:Constructor(value)
  self._blockFlag = value or 0
end

function BlockFlagComponent:GetBlockFlag()
  return self._blockFlag
end

function Entity:BlockFlag()
  return self:GetComponent(self.WEComponentsEnum.BlockFlag)
end

function Entity:HasBlockFlag()
  return self:HasComponent(self.WEComponentsEnum.BlockFlag)
end

function Entity:AddBlockFlag(value)
  local index = self.WEComponentsEnum.BlockFlag
  local component = BlockFlagComponent:New(value)
  self:AddComponent(index, component)
end

function Entity:ReplaceBlockFlag(value)
  local index = self.WEComponentsEnum.BlockFlag
  local component = BlockFlagComponent:New(value)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveBlockFlag()
  if self:HasBlockFlag() then
    self:RemoveComponent(self.WEComponentsEnum.BlockFlag)
  end
end
