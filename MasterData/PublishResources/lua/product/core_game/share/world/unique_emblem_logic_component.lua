_class("EmblemLogicComponent", Object)
EmblemLogicComponent = EmblemLogicComponent

function EmblemLogicComponent:Constructor(world)
end

function EmblemLogicComponent:Initialize()
end

function MainWorld:EmblemLogic()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.EmblemLogic)
end

function MainWorld:HasEmblemLogic()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.EmblemLogic) ~= nil
end

function MainWorld:AddEmblemLogic(world)
  local index = self.BW_UniqueComponentsEnum.EmblemLogic
  local component = EmblemLogicComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveEmblemLogic()
  if self:HasEmblemLogic() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.EmblemLogic, nil)
  end
end
