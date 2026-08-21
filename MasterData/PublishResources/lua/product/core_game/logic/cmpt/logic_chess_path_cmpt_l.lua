_class("LogicChessPathComponent", Object)
LogicChessPathComponent = LogicChessPathComponent

function LogicChessPathComponent:Constructor()
  self._chessPath = {}
  self._chessPetEntityID = -1
  self._pickUpPos = nil
  self._walkResultList = {}
end

function LogicChessPathComponent:ClearLogicChessPath()
  self._chessPath = {}
  self._chessPetEntityID = -1
  self._pickUpPos = nil
  self._walkResultList = {}
end

function LogicChessPathComponent:GetLogicChessPath()
  return self._chessPath
end

function LogicChessPathComponent:SetLogicChessPath(chessPath)
  self._chessPath = chessPath
end

function LogicChessPathComponent:GetLogicChessPetEntityID()
  return self._chessPetEntityID
end

function LogicChessPathComponent:SetLogicChessPetEntityID(chessPetEntityID)
  self._chessPetEntityID = chessPetEntityID
end

function LogicChessPathComponent:GetLogicWalkResultList()
  return self._walkResultList
end

function LogicChessPathComponent:SetLogicWalkResultList(walkResultList)
  self._walkResultList = walkResultList
end

function LogicChessPathComponent:GetLogicPickUpPos()
  return self._pickUpPos
end

function LogicChessPathComponent:SetLogicPickUpPos(pickUpPos)
  self._pickUpPos = pickUpPos
end

function Entity:LogicChessPath()
  return self:GetComponent(self.WEComponentsEnum.LogicChessPath)
end

function Entity:HasLogicChessPath()
  return self:HasComponent(self.WEComponentsEnum.LogicChessPath)
end

function Entity:AddLogicChessPath()
  local index = self.WEComponentsEnum.LogicChessPath
  local component = LogicChessPathComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicChessPath()
  local index = self.WEComponentsEnum.LogicChessPath
  local component = LogicChessPathComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicChessPath()
  if self:HasLogicChessPath() then
    self:RemoveComponent(self.WEComponentsEnum.LogicChessPath)
  end
end
