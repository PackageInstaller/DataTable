_class("UIN27PostPackageGridManager", Object)
UIN27PostPackageGridManager = UIN27PostPackageGridManager
local testItem = {
  {
    1,
    1,
    1,
    1
  },
  {
    1,
    0,
    0,
    1
  },
  {
    1,
    1,
    1,
    1
  }
}

function UIN27PostPackageGridManager:Constructor(mainGridWidth, mainGridHeight)
  self._mainGridWidth = mainGridWidth
  self._mainGridHeight = mainGridHeight
  self._itemDetailMap = {}
  local itemDetailCfg = Cfg.cfg_post_station_game_item_detail({})
  for _, v in pairs(itemDetailCfg) do
    self._itemDetailMap[v.ID] = v
  end
  self._mainMatrix = {}
  self._mainGridItemMap = {}
  self._atomicItemID = 0
  self._cacheCheckItemWidgetMatrix = {}
end

function UIN27PostPackageGridManager:InjectWidgetToMainMatrix(x, y, widget)
  self._mainMatrix[x] = self._mainMatrix[x] or {}
  self._mainMatrix[x][y] = widget
end

function UIN27PostPackageGridManager:GetMainMatrixWidget(x, y)
  if not self:CheckXInBound(x) or not self:CheckYInBound(y) then
    return nil
  end
  return self._mainMatrix[x][y]
end

function UIN27PostPackageGridManager:GetItemDetail(itemID)
  return self._itemDetailMap[itemID]
end

function UIN27PostPackageGridManager:CopyMatrix(oriMatrix)
  local col = #oriMatrix
  local row = #oriMatrix[1]
  local matrix_new = {}
  for i = 1, col do
    for j = 1, row do
      matrix_new[i] = matrix_new[i] or {}
      matrix_new[i][j] = oriMatrix[i][j]
    end
  end
  return matrix_new
end

function UIN27PostPackageGridManager:GetItemSize(itemID)
  local detail = self._itemDetailMap[itemID]
  return #detail.Matrix[1], #detail.Matrix
end

function UIN27PostPackageGridManager:GetItemNDCCenter(itemID)
  local detail = self._itemDetailMap[itemID]
  local center = detail.Center
  local matrix = detail.Matrix
  local cx, cy = center[1], center[2]
  local mx, my = #matrix[1], #matrix
  return cx / mx, cy / my
end

function UIN27PostPackageGridManager:TryToInsertMainMatrix(itemID, matrix, widget, rotationID, scale)
  local item = self._itemDetailMap[itemID]
  if item then
    local centerFlip = rotationID & 1 == 0
    local center = table.shallowcopy(item.Center)
    if centerFlip then
      center[1], center[2] = center[2], center[1]
    end
    local mx, my = #matrix[1], #matrix
    local cx, cy = center[1], center[2]
    local wx, wy = widget:GetY(), widget:GetX()
    local offx, offy = wx - cx, wy - cy
    local itemWidgetMatrix = {}
    for i = 1, mx do
      for j = 1, my do
        local cacuWidgetCol = j + offy
        local cacuWidgetRaw = i + offx
        if not self:CheckXInBound(cacuWidgetRaw) or not self:CheckYInBound(cacuWidgetCol) then
          return false
        end
        local cacuWidget = self._mainMatrix[cacuWidgetCol][cacuWidgetRaw]
        if cacuWidget:GetIsOccupy() and matrix[j][i] == 1 then
          return false
        end
        if matrix[j][i] == 1 then
          table.insert(itemWidgetMatrix, cacuWidget)
        end
      end
    end
    local blockList = {}
    self._atomicItemID = self._atomicItemID + 1
    for _, v in pairs(itemWidgetMatrix) do
      v:SetOccupy(true, self._atomicItemID, itemID)
      table.insert(blockList, v)
    end
    local scaleX = 0 < scale.x and 1 or -1
    local scaleY = 0 < scale.y and 1 or -1
    self._mainGridItemMap[self._atomicItemID] = {
      itemID = itemID,
      matrix = matrix,
      widget = widget,
      rotationID = rotationID,
      scale = Vector3(scaleX, scaleY, 1),
      blockList = blockList
    }
    return true, self._atomicItemID
  end
  return false, nil
end

function UIN27PostPackageGridManager:ClearCheckBlocksColor()
  for _, v in pairs(self._cacheCheckItemWidgetMatrix) do
    v:ClearCheckColor()
  end
  table.clear(self._cacheCheckItemWidgetMatrix)
end

function UIN27PostPackageGridManager:CheckItemHoveredOnMainMatrix(itemID, matrix, widget, rotationID)
  self:ClearCheckBlocksColor()
  local item = self._itemDetailMap[itemID]
  local centerFlip = rotationID & 1 == 0
  local center = table.shallowcopy(item.Center)
  if centerFlip then
    center[1], center[2] = center[2], center[1]
  end
  local mx, my = #matrix[1], #matrix
  local cx, cy = center[1], center[2]
  local wx, wy = widget:GetY(), widget:GetX()
  local offx, offy = wx - cx, wy - cy
  local checkResult = true
  for i = 1, mx do
    for j = 1, my do
      local cacuWidgetCol = j + offy
      local cacuWidgetRaw = i + offx
      if not self:CheckXInBound(cacuWidgetRaw) or not self:CheckYInBound(cacuWidgetCol) then
        checkResult = false
      else
        local cacuWidget = self._mainMatrix[cacuWidgetCol][cacuWidgetRaw]
        if cacuWidget:GetIsOccupy() and matrix[j][i] == 1 then
          checkResult = false
        end
        if matrix[j][i] == 1 then
          table.insert(self._cacheCheckItemWidgetMatrix, cacuWidget)
        end
      end
    end
  end
  for _, v in pairs(self._cacheCheckItemWidgetMatrix) do
    v:ShowCheckColor(checkResult)
  end
end

function UIN27PostPackageGridManager:ClearGrid()
  table.clear(self._mainGridItemMap)
  for _, array in pairs(self._mainMatrix) do
    for _, v in pairs(array) do
      v:SetOccupy(false, nil, nil)
    end
  end
end

function UIN27PostPackageGridManager:RemoveItemDetailInGridMap(atomicItemID)
  self._mainGridItemMap[atomicItemID] = nil
end

function UIN27PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID)
  return self._mainGridItemMap[atomicItemID]
end

function UIN27PostPackageGridManager:CheckXInBound(value)
  if 0 < value and value <= self._mainGridWidth then
    return true
  end
  return false
end

function UIN27PostPackageGridManager:CheckYInBound(value)
  if 0 < value and value <= self._mainGridHeight then
    return true
  end
  return false
end

function UIN27PostPackageGridManager:RotateItemClockwise(itemMatrix)
  local col = #itemMatrix
  local row = #itemMatrix[1]
  local matrix_new = {}
  for i = 1, col do
    for j = 1, row do
      matrix_new[row - j + 1] = matrix_new[row - j + 1] or {}
      matrix_new[row - j + 1][i] = itemMatrix[i][j]
    end
  end
  return matrix_new
end

function UIN27PostPackageGridManager:FlipItem(itemMatrix)
  local col = #itemMatrix
  local row = #itemMatrix[1]
  local center = math.floor(row / 2)
  for i = 1, col do
    for j = 1, center do
      itemMatrix[i][j], itemMatrix[i][row - j + 1] = itemMatrix[i][row - j + 1], itemMatrix[i][j]
    end
  end
  return itemMatrix
end
