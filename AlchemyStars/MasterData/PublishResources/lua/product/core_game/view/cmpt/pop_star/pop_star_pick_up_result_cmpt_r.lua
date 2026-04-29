_class("PopStarPickUpResultComponent", Object)
PopStarPickUpResultComponent = PopStarPickUpResultComponent

function PopStarPickUpResultComponent:Constructor()
  self._pickUpGridPos = Vector2(0, 0)
  self._popStarConnectPieces = {}
end

function PopStarPickUpResultComponent:GetPopStarPickUpPos()
  return self._pickUpGridPos
end

function PopStarPickUpResultComponent:SetPopStarPickUpPos(pickUpGridPos)
  self._pickUpGridPos = pickUpGridPos
end

function PopStarPickUpResultComponent:GetPopStarConnectPieces()
  return self._popStarConnectPieces
end

function PopStarPickUpResultComponent:SetPopStarConnectPieces(pieces)
  self._popStarConnectPieces = pieces
end

function PopStarPickUpResultComponent:ResetPopStarPickUp()
  self._pickUpGridPos = Vector2(0, 0)
  self._popStarConnectPieces = {}
end

function Entity:PopStarPickUpResult()
  return self:GetComponent(self.WEComponentsEnum.PopStarPickUpResult)
end

function Entity:HasPopStarPickUpResult()
  return self:HasComponent(self.WEComponentsEnum.PopStarPickUpResult)
end

function Entity:AddPopStarPickUpResult()
  local index = self.WEComponentsEnum.PopStarPickUpResult
  local component = PopStarPickUpResultComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePopStarPickUpResult()
  local component = self:GetComponent(self.WEComponentsEnum.PopStarPickUpResult)
  local index = self.WEComponentsEnum.PopStarPickUpResult
  self:ReplaceComponent(index, component)
end

function Entity:RemovePopStarPickUpResult()
  if self:HasPopStarPickUpResult() then
    self:RemoveComponent(self.WEComponentsEnum.PopStarPickUpResult)
  end
end
