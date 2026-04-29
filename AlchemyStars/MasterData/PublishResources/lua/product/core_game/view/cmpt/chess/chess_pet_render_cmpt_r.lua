_class("ChessPetRenderComponent", Object)

function ChessPetRenderComponent:Constructor()
  self._canMoveEffectEntityID = nil
  self._selectEffectEntityID = nil
end

function ChessPetRenderComponent:GetCanMoveEffectEntityID()
  return self._canMoveEffectEntityID
end

function ChessPetRenderComponent:SetCanMoveEffectEntityID(entityID)
  self._canMoveEffectEntityID = entityID
end

function ChessPetRenderComponent:GetSelectEffectEntityID()
  return self._selectEffectEntityID
end

function ChessPetRenderComponent:SetSelectEffectEntityID(entityID)
  self._selectEffectEntityID = entityID
end

function ChessPetRenderComponent:WEC_PostInitialize(owner)
end

function ChessPetRenderComponent:WEC_PostRemoved()
end

function Entity:ChessPetRender()
  return self:GetComponent(self.WEComponentsEnum.ChessPetRender)
end

function Entity:HasChessPetRender()
  return self:HasComponent(self.WEComponentsEnum.ChessPetRender)
end

function Entity:AddChessPetRender()
  local index = self.WEComponentsEnum.ChessPetRender
  local component = ChessPetRenderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceChessPetRender()
  local index = self.WEComponentsEnum.ChessPetRender
  local component = ChessPetRenderComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveChessPetRender()
  if self:HasChessPetRender() then
    self:RemoveComponent(self.WEComponentsEnum.ChessPetRender)
  end
end
