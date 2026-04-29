_class("MarkGridComponent", Object)
MarkGridComponent = MarkGridComponent

function MarkGridComponent:Constructor()
  self.gridIndexMap = {}
end

function MarkGridComponent:MarkGrid(index, series)
  series = series or 1
  if not self.gridIndexMap[series] then
    self.gridIndexMap[series] = {}
  end
  Log.info(self._className, "Pos ", index, " marked. ")
  self.gridIndexMap[series][index] = true
end

function MarkGridComponent:IsPosMarked(series, nPosIndex)
  series = series or 1
  if not self.gridIndexMap[series] then
    return false
  end
  return self.gridIndexMap[series][nPosIndex]
end

function MarkGridComponent:ClearMark(series)
  series = series or 1
  if not self.gridIndexMap[series] then
    return
  end
  local result = {}
  for _, index in ipairs(self.gridIndexMap[series]) do
    table.insert(result, Vector2.Index2Pos(index))
  end
  self.gridIndexMap[series] = nil
  return result
end

function Entity:MarkGridComponent()
  return self:GetComponent(self.WEComponentsEnum.MarkGrid)
end

function Entity:HasMarkGridComponent()
  return self:HasComponent(self.WEComponentsEnum.MarkGrid)
end

function Entity:AddMarkGridComponent()
  local index = self.WEComponentsEnum.MarkGrid
  local component = MarkGridComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceMarkGridComponent()
  local index = self.WEComponentsEnum.MarkGrid
  local component = MarkGridComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMarkGridComponent()
  if self:HasMarkGrid() then
    self:RemoveComponent(self.WEComponentsEnum.MarkGrid)
  end
end
