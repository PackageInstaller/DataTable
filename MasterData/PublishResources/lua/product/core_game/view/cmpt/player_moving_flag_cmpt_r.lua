_class("PlayerMovingFlagComponent", Object)

function PlayerMovingFlagComponent:Constructor()
end

function Entity:PlayerMovingFlag()
  return self:GetComponent(self.WEComponentsEnum.PlayerMovingFlag)
end

function Entity:HasPlayerMovingFlag()
  return self:HasComponent(self.WEComponentsEnum.PlayerMovingFlag)
end

function Entity:AddPlayerMovingFlag()
  local index = self.WEComponentsEnum.PlayerMovingFlag
  local component = PlayerMovingFlagComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePlayerMovingFlag()
  local index = self.WEComponentsEnum.PlayerMovingFlag
  local component = PlayerMovingFlagComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePlayerMovingFlag()
  if self:HasPlayerMovingFlag() then
    self:RemoveComponent(self.WEComponentsEnum.PlayerMovingFlag)
  end
end
