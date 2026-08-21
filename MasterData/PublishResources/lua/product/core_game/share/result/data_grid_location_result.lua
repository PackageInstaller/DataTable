_class("DataGridLocationResult", Object)
DataGridLocationResult = DataGridLocationResult

function DataGridLocationResult:Constructor()
  self._bornPos = Vector2(0, 0)
  self._bornDir = Vector2(0, 0)
  self._bornOffset = Vector2(0, 0)
  self._bornHeight = 0
  self._damageOffset = Vector2(0, 0)
end

function DataGridLocationResult:SetGridLocResultBornPos(pos)
  self._bornPos = pos
end

function DataGridLocationResult:GetGridLocResultBornPos()
  return self._bornPos
end

function DataGridLocationResult:SetGridLocResultBornDir(dir)
  self._bornDir = dir
end

function DataGridLocationResult:GetGridLocResultBornDir()
  return self._bornDir
end

function DataGridLocationResult:SetGridLocResultBornOffset(offset)
  self._bornOffset = offset
end

function DataGridLocationResult:GetGridLocResultBornOffset()
  return self._bornOffset
end

function DataGridLocationResult:SetGridLocResultBornHeight(height)
  self._bornHeight = height
end

function DataGridLocationResult:GetGridLocResultBornHeight()
  return self._bornHeight
end

function DataGridLocationResult:SetGridLocResultDamageOffset(offset)
  self._damageOffset = offset
end

function DataGridLocationResult:GetGridLocResultDamageOffset()
  return self._damageOffset
end
