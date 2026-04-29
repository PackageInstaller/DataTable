_class("UICN7N36PostPackageGridManager", Object)
UICN7N36PostPackageGridManager = UICN7N36PostPackageGridManager
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

function UICN7N36PostPackageGridManager:Constructor(mainGridWidth, mainGridHeight)
  self._mainGridWidth = mainGridWidth
  self._mainGridHeight = mainGridHeight
  self._itemDetailMap = {}
  local itemDetailCfg = Cfg.cfg_season_debris_item({})
  for _, v in pairs(itemDetailCfg) do
    self._itemDetailMap[v.ID] = v
  end
  self._mainMatrix = {}
  self._mainGridItemMap = {}
  self._atomicItemID = 0
  self._cacheCheckItemWidgetMatrix = {}
end

function UICN7N36PostPackageGridManager:InjectWidgetToMainMatrix(x, y, widget)
  self._mainMatrix[x] = self._mainMatrix[x] or {}
  self._mainMatrix[x][y] = widget
end

function UICN7N36PostPackageGridManager:GetWidgetFromGameObjectInstanceID(instanceID)
  for _, arr in pairs(self._mainMatrix) do
    for _, v in pairs(arr) do
      if v:GetInstanceID() == instanceID then
        return v
      end
    end
  end
end

function UICN7N36PostPackageGridManager:GetMainMatrix()
  return self._mainMatrix
end

function UICN7N36PostPackageGridManager:GetMainGridItemMap()
  return self._mainGridItemMap
end

function UICN7N36PostPackageGridManager:GetMainMatrixWidget(x, y)
  if not self:CheckXInBound(x) or not self:CheckYInBound(y) then
    return nil
  end
  return self._mainMatrix[x][y]
end

function UICN7N36PostPackageGridManager:GetItemDetail(itemID)
  return self._itemDetailMap[itemID]
end

function UICN7N36PostPackageGridManager:CopyMatrix(oriMatrix)
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

function UICN7N36PostPackageGridManager:GetItemSize(itemID)
  local detail = self._itemDetailMap[itemID]
  return #detail.Matrix[1], #detail.Matrix
end

function UICN7N36PostPackageGridManager:GetItemNDCCenter(itemID, isDraging)
  local detail = self._itemDetailMap[itemID]
  local center = detail.RotateCenter
  local matrix = detail.Matrix
  local cx, cy = center[1], center[2]
  local mx, my = #matrix[1], #matrix
  local offsetX = 1 / mx / 2
  local offsetY = 1 / my / 2
  if not isDraging then
    offsetX = 0
    offsetY = 0
  end
  return cx / mx - offsetX, cy / my - offsetY
end

function UICN7N36PostPackageGridManager:GetCurrentItemNDCCenter(matrix, center)
  local cx, cy = center[1], center[2]
  local mx, my = #matrix[1], #matrix
  return cx / mx, cy / my
end

function UICN7N36PostPackageGridManager:GetCenterFromPivot(matrix, pivot)
  local px, py = pivot[1], 1 - pivot[2]
  local mx, my = #matrix[1], #matrix
  local cx, cy = math.ceil(px * mx), math.ceil(py * my)
  return cx, cy
end

function UICN7N36PostPackageGridManager:TryToInsertMainMatrix(itemID, matrix, widget, rotationID, center)
  local item = self._itemDetailMap[itemID]
  if item then
    if not center then
      local centerFlip = rotationID & 1 == 0
      center = table.shallowcopy(item.RotateCenter)
      if centerFlip then
        center[1], center[2] = center[2], center[1]
      end
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
        if not self:CheckXInBound(cacuWidgetCol) or not self:CheckYInBound(cacuWidgetRaw) then
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
    self._mainGridItemMap[self._atomicItemID] = {
      itemID = itemID,
      matrix = matrix,
      widget = widget,
      rotationID = rotationID,
      blockList = blockList
    }
    return true, self._atomicItemID
  end
  return false, nil
end

function UICN7N36PostPackageGridManager:ClearCheckBlocksColor()
  for _, v in pairs(self._cacheCheckItemWidgetMatrix) do
    v:ClearCheckColor()
  end
  table.clear(self._cacheCheckItemWidgetMatrix)
end

function UICN7N36PostPackageGridManager:AutoSetItemOnMainMatrix(itemID, callback)
  local tmpMatrix = self._itemDetailMap[itemID].Matrix
  local passCount = self._itemDetailMap[itemID].PassCount
  local rotationID = 1
  for i = 1, passCount do
    tmpMatrix = i == 1 and tmpMatrix or self:RotateItemClockwise(tmpMatrix)
    for row = 1, #self._mainMatrix do
      for col = 1, #self._mainMatrix[row] do
        local widget = self._mainMatrix[row][col]
        if not widget:GetIsOccupy() then
          local result = self:CheckItemHoveredOnMainMatrix(itemID, tmpMatrix, widget, rotationID, nil, true)
          if result then
            local result, atomicItemID = self:TryToInsertMainMatrix(itemID, tmpMatrix, widget, rotationID)
            callback(result, atomicItemID, widget, rotationID)
            return
          end
        end
      end
    end
    rotationID = rotationID + 1
  end
  callback(false, nil, nil)
end

function UICN7N36PostPackageGridManager:CheckItemHoveredOnMainMatrix(itemID, matrix, widget, rotationID, center, hideCheckBlock)
  self:ClearCheckBlocksColor()
  local item = self._itemDetailMap[itemID]
  if not center then
    local centerFlip = rotationID & 1 == 0
    center = table.shallowcopy(item.RotateCenter)
    if centerFlip then
      center[1], center[2] = center[2], center[1]
    end
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
      if not self:CheckXInBound(cacuWidgetCol) or not self:CheckYInBound(cacuWidgetRaw) then
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
  if not hideCheckBlock then
    for _, v in pairs(self._cacheCheckItemWidgetMatrix) do
      v:ShowCheckColor(checkResult)
    end
  end
  return checkResult, self._cacheCheckItemWidgetMatrix
end

function UICN7N36PostPackageGridManager:ClearGrid()
  table.clear(self._mainGridItemMap)
  for _, array in pairs(self._mainMatrix) do
    for _, v in pairs(array) do
      if not v:GetIsEmpty() then
        v:SetOccupy(false, nil, nil)
      end
    end
  end
end

function UICN7N36PostPackageGridManager:RemoveItemDetailInGridMap(atomicItemID)
  self._mainGridItemMap[atomicItemID] = nil
end

function UICN7N36PostPackageGridManager:GetItemDetailOnGridMap(atomicItemID)
  return self._mainGridItemMap[atomicItemID]
end

function UICN7N36PostPackageGridManager:CheckXInBound(value)
  if 0 < value and value <= self._mainGridHeight then
    return true
  end
  return false
end

function UICN7N36PostPackageGridManager:CheckYInBound(value)
  if 0 < value and value <= self._mainGridWidth then
    return true
  end
  return false
end

function UICN7N36PostPackageGridManager:RotateItemClockwise(itemMatrix)
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

function UICN7N36PostPackageGridManager:FlipItem(itemMatrix)
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
