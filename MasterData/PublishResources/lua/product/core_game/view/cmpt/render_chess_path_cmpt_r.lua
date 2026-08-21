_class("RenderChessPathComponent", Object)
RenderChessPathComponent = RenderChessPathComponent

function RenderChessPathComponent:Constructor(chessPath, chessPetEntityID, walkResultList, pickUpPos)
  self._chessPath = chessPath
  self._chessPetEntityID = chessPetEntityID
  self._pickUpPos = pickUpPos
  self._walkResultList = walkResultList
end

function RenderChessPathComponent:ClearRenderChessPath()
  self._chessPath = {}
  self._chessPetEntityID = -1
  self._walkResultList = {}
end

function RenderChessPathComponent:GetRenderChessPath()
  return self._chessPath
end

function RenderChessPathComponent:SetRenderChessPath(chessPath)
  self._chessPath = chessPath
end

function RenderChessPathComponent:GetRenderChessPetEntityID()
  return self._chessPetEntityID
end

function RenderChessPathComponent:SetRenderChessPetEntityID(chessPetEntityID)
  self._chessPetEntityID = chessPetEntityID
end

function RenderChessPathComponent:GetRenderWalkResultList()
  return self._walkResultList
end

function RenderChessPathComponent:SetRenderWalkResultList(walkResultList)
  self._walkResultList = walkResultList
end

function RenderChessPathComponent:GetRenderPickUpPos()
  return self._pickUpPos
end

function Entity:RenderChessPath()
  return self:GetComponent(self.WEComponentsEnum.RenderChessPath)
end

function Entity:HasRenderChessPath()
  return self:HasComponent(self.WEComponentsEnum.RenderChessPath)
end

function Entity:AddRenderChessPath()
  local index = self.WEComponentsEnum.RenderChessPath
  local component = RenderChessPathComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderChessPath(chessPath, chessPetEntityID, walkResultList, pickUpPos)
  local index = self.WEComponentsEnum.RenderChessPath
  local component = RenderChessPathComponent:New(chessPath, chessPetEntityID, walkResultList, pickUpPos)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderChessPath()
  if self:HasRenderChessPath() then
    self:RemoveComponent(self.WEComponentsEnum.RenderChessPath)
  end
end
