_class("DataChessPathResult", Object)
DataChessPathResult = DataChessPathResult

function DataChessPathResult:Constructor()
  self._chessPathResult = {}
  self._chessPetEntityID = -1
  self._walkResultList = {}
  self._pickUpPos = nil
end

function DataChessPathResult:SetChessPathResult(res)
  self._chessPathResult = res
end

function DataChessPathResult:GetChessPathResult()
  return self._chessPathResult
end

function DataChessPathResult:SetChessPetEntityID(chessPetEntityID)
  self._chessPetEntityID = chessPetEntityID
end

function DataChessPathResult:GetChessPetEntityID()
  return self._chessPetEntityID
end

function DataChessPathResult:SetChessWalkResultList(walkResultList)
  self._walkResultList = walkResultList
end

function DataChessPathResult:GetChessWalkResultList()
  return self._walkResultList
end

function DataChessPathResult:SetChessPickUpPos(pickUpPos)
  self._pickUpPos = pickUpPos
end

function DataChessPathResult:GetChessPickUpPos()
  return self._pickUpPos
end
