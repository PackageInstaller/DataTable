local CS = _ENV.CS
local MapDragComponent, Super = System.NewComponent("MapDragComponent")

function MapDragComponent:ctor(moveRootTrans, maskTrans, moveBorderUIs)
  Super.ctor(self)
  self.moveRootTrans = moveRootTrans
  self.maskTrans = maskTrans
  self.moveBorderUIs = moveBorderUIs
  self.mapScale = self.moveRootTrans.localScale
  self.lastRootPos = {
    x = self.moveRootTrans.localPosition.x,
    y = self.moveRootTrans.localPosition.y,
    z = self.moveRootTrans.localPosition.z
  }
  self:Init()
end

function MapDragComponent:Init()
  local edgeDist = DT.GetOriginalConstant("Map_Edge_Distance")
  self.deltaHeight = tonumber(edgeDist[1])
  self.deltaWidth = edgeDist[2] and tonumber(edgeDist[2]) or self.deltaHeight
end

function MapDragComponent:OnMove(x, y)
  LuaProfiler.Begin("MapDragComponent:OnMove")
  if self.isDragEnabled then
    if self.lastMovePos and not self.isMoving then
      local minMoveDist = 10
      if minMoveDist < math.abs(self.lastMovePos.x - x) or minMoveDist < math.abs(self.lastMovePos.y - y) then
        self.isMoving = true
      end
    end
    if self.lastMovePos and self.isMoving then
      local cx = x - self.lastMovePos.x
      local cy = y - self.lastMovePos.y
      if not self.moveRootPos then
        local pos = self.moveRootTrans.localPosition
        self.moveRootPos = {
          x = pos.x,
          y = pos.y,
          z = pos.z
        }
      end
      local newX = self.moveRootPos.x + cx
      local newY = self.moveRootPos.y + cy
      local newpos = {
        x = newX,
        y = newY,
        z = self.moveRootPos.z
      }
      if not self:CheckNewPosIsValid(newpos) then
        self.lastMovePos = {x = x, y = y}
        return
      end
      self.lastRootPos = self.moveRootPos
      self.moveRootTrans.localPosition = newpos
      self.moveRootPos = newpos
    end
    self.lastMovePos = {x = x, y = y}
  end
  LuaProfiler.End()
end

function MapDragComponent:CheckNewPosIsValid(newRootMovePos)
  if not newRootMovePos then
    local rootMoveTransform = self.moveRootTrans
    newRootMovePos = rootMoveTransform.localPosition
  end
  local posBorder = self:GetMovePosBorder()
  local outBorder = {}
  if newRootMovePos.x < posBorder.left then
    table.insert(outBorder, {
      pos = posBorder.left,
      border = "left"
    })
  end
  if newRootMovePos.x > posBorder.right then
    table.insert(outBorder, {
      pos = posBorder.right,
      border = "right"
    })
  end
  if newRootMovePos.y < posBorder.bottom then
    table.insert(outBorder, {
      pos = posBorder.bottom,
      border = "bottom"
    })
  end
  if newRootMovePos.y > posBorder.top then
    table.insert(outBorder, {
      pos = posBorder.top,
      border = "top"
    })
  end
  if #outBorder >= 2 then
    return false
  elseif 1 == #outBorder then
    local info = outBorder[1]
    if "left" == info.border or info.border == "right" then
      newRootMovePos.x = info.pos
    else
      newRootMovePos.y = info.pos
    end
    return true
  end
  return true
end

function MapDragComponent:OnEnableDrag()
  self.isDragEnabled = true
  self.lastMovePos = nil
end

function MapDragComponent:GetMovePosBorder()
  if not self.areaRect then
    local rect = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
      middle = {x = 0, y = 0}
    }
    local inited = false
    
    local function calRect(item)
      if item then
        local itemPos = item.transform.localPosition
        local itemSize = item.transform.sizeDelta
        if not inited then
          rect.left = itemPos.x - itemSize.x / 2
          rect.right = itemPos.x + itemSize.x / 2
          rect.top = itemPos.y + itemSize.y / 2
          rect.bottom = itemPos.y - itemSize.y / 2
          inited = true
        else
          rect.left = math.min(rect.left, itemPos.x - itemSize.x / 2)
          rect.right = math.max(rect.right, itemPos.x + itemSize.x / 2)
          rect.top = math.max(rect.top, itemPos.y + itemSize.y / 2)
          rect.bottom = math.min(rect.bottom, itemPos.y - itemSize.y / 2)
        end
      end
    end
    
    if 1 == #self.moveBorderUIs then
      calRect(self.moveBorderUIs[1])
    else
      for _, uiNode in ipairs(self.moveBorderUIs) do
        calRect(uiNode)
      end
    end
    self.mapScale = self.moveRootTrans.localScale
    rect.left = rect.left * self.mapScale.x - self.deltaWidth
    rect.right = rect.right * self.mapScale.x + self.deltaWidth
    rect.top = rect.top * self.mapScale.y + self.deltaHeight
    rect.bottom = rect.bottom * self.mapScale.y - self.deltaHeight
    rect.middle = {
      x = (rect.right + rect.left) / 2 * self.mapScale.x,
      y = (rect.top + rect.bottom) / 2 * self.mapScale.y
    }
    self.areaRect = rect
  end
  local posBorder = {}
  local sightBorder = self:GetCurSightBorder()
  local left = sightBorder.left > self.areaRect.left and sightBorder.left - self.areaRect.left or 0
  local right = sightBorder.right < self.areaRect.right and self.areaRect.right - sightBorder.right or 0
  local top = sightBorder.top < self.areaRect.top and self.areaRect.top - sightBorder.top or 0
  local bottom = sightBorder.bottom > self.areaRect.bottom and sightBorder.bottom - self.areaRect.bottom or 0
  posBorder.left = self.lastRootPos.x - right
  posBorder.right = self.lastRootPos.x + left
  posBorder.top = self.lastRootPos.y + bottom
  posBorder.bottom = self.lastRootPos.y - top
  return posBorder
end

function MapDragComponent:GetCurSightBorder()
  local maksRectSize = self.maskTrans.sizeDelta
  local sightBorder = {}
  sightBorder.left = -self.lastRootPos.x - maksRectSize.x / 2
  sightBorder.right = -self.lastRootPos.x + maksRectSize.x / 2
  sightBorder.top = -self.lastRootPos.y + maksRectSize.y / 2
  sightBorder.bottom = -self.lastRootPos.y - maksRectSize.y / 2
  return sightBorder
end

function MapDragComponent:OnMoveEnd()
  self.isMoving = nil
  self.isDragEnabled = nil
end

function MapDragComponent:LocateToPosition(pos)
  local targetPos = self.maskTrans:InverseTransformPoint(pos)
  targetPos = {
    x = -targetPos.x,
    y = -targetPos.y,
    z = targetPos.z
  }
  self.moveRootTrans.localPosition = targetPos
  self.moveRootPos = targetPos
  self.lastRootPos = targetPos
end

return MapDragComponent
