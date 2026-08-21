_class("DataPieceTypeResult", Object)
DataPieceTypeResult = DataPieceTypeResult

function DataPieceTypeResult:Constructor()
  self._pieceTable = nil
  self._pieceTypes = nil
end

function DataPieceTypeResult:SetPieceTypes(t)
  self._pieceTypes = t
end

function DataPieceTypeResult:GetPieceTypes()
  return self._pieceTypes
end

function DataPieceTypeResult:SetPieceTable(t)
  self._pieceTable = t
end

function DataPieceTypeResult:GetPieceTable()
  return self._pieceTable
end
