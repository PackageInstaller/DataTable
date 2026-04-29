_class("ConnectPiecesComponent", Object)
ConnectPiecesComponent = ConnectPiecesComponent

function ConnectPiecesComponent:Constructor(ConnectPieces, elementType)
  self._ConnectPieces = ConnectPieces
  self._elementType = elementType
end

function ConnectPiecesComponent:GetConnectPieces()
  return self._ConnectPieces
end

function ConnectPiecesComponent:GetPieceType()
  return self._elementType
end

function Entity:ConnectPieces()
  return self:GetComponent(self.WEComponentsEnum.ConnectPieces)
end

function Entity:HasConnectPieces()
  return self:HasComponent(self.WEComponentsEnum.ConnectPieces)
end

function Entity:AddConnectPieces(ConnectPieces, elementType)
  local index = self.WEComponentsEnum.ConnectPieces
  local component = ConnectPiecesComponent:New(ConnectPieces, elementType)
  self:AddComponent(index, component)
end

function Entity:ReplaceConnectPieces(ConnectPieces, elementType)
  local index = self.WEComponentsEnum.ConnectPieces
  local component = ConnectPiecesComponent:New(ConnectPieces, elementType)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveConnectPieces()
  if self:HasConnectPieces() then
    self:RemoveComponent(self.WEComponentsEnum.ConnectPieces)
  end
end
