local LuaSectorScroll = NewClass("LuaSectorScroll")
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local T_UITableview = typeof(CS.UITableview)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local ShareVector3 = Vector3(0, 0, 0)
local OutSightVector3 = Vector3(9999, 9999, 0)
local Input = CS.UnityEngine.Input

function LuaSectorScroll:ctor(container)
  self.container = container
  self.tabView = container:GetComponent(T_UITableview)
  local cellOffset = self.tabView.cellOffset
  self.origOffset = Vector2(cellOffset.x, cellOffset.y)
  self.extraOffset = Vector2.zero
  self.scrollRect = container:GetComponent(T_ScrollRect)
  self.viewport = self.scrollRect.viewport
  self.content = self.scrollRect.content
  self.viewportRect = self.viewport.transform.rect
  self.viewPortHeight = self.viewportRect.height
  self.centerIndex = nil
end

function LuaSectorScroll:InitSector(bendAngle, onCenterCellChangeCb)
  self.sector = CircleScrollSector(bendAngle, self.viewPortHeight)
  self.onCenterCellChangeCb = onCenterCellChangeCb
  local numberCellsInTableview = self.tabView.numberCellsInTableview
  local tableCellAtIndex = self.tabView.tableCellAtIndex
  local tableCellSizeForIndex = self.tabView.tableCellSizeForIndex
  local halfViewportHeight = self.viewPortHeight * 0.5
  local isAlignCenter = self.tabView.isAlignCenter
  assert(tableCellSizeForIndex, "UITableView tableCellSizeForIndex函数未初始化")
  local cellSize = tableCellSizeForIndex(self.tabView, 0)
  local offsetY = halfViewportHeight + (isAlignCenter and 0 or -cellSize.y * 0.5)
  local cellCount = self.tabView.numberCellsInTableview(self.tabView)
  local lastCellSize = tableCellSizeForIndex(self.tabView, cellCount - 1)
  local sizeExpandY = halfViewportHeight - (isAlignCenter and 0 or lastCellSize.y * 0.5)
  self.tabView.contentSizeAdjustment = Vector2(0, sizeExpandY)
  
  function self.tabView.numberCellsInTableview()
    return numberCellsInTableview(self.tabView) + 1
  end
  
  function self.tabView.tableCellAtIndex(tabView, idx)
    if 0 == idx then
      local cell = tableCellAtIndex(tabView, 1)
      return cell
    end
    do return tableCellAtIndex, tabView end
    return tableCellAtIndex, tabView, idx - 1
  end
  
  function self.tabView.tableCellSizeForIndex(tabView, idx)
    if 0 == idx then
      cellSize.y = offsetY
      return cellSize
    end
    do return tableCellSizeForIndex, tabView end
    return tableCellSizeForIndex, tabView, idx - 1
  end
end

function LuaSectorScroll:SetCenterIndex(index)
  if index ~= self.centerIndex then
    local oldIndex = self.centerIndex
    self.centerIndex = index
    if not self.tabView.isReady then
      self._isDirty = true
    end
    if self.onCenterCellChangeCb then
      self.onCenterCellChangeCb(index, oldIndex)
    end
  end
end

function LuaSectorScroll:ScrollIndexToCenter(index)
end

function LuaSectorScroll:UpdateCirclePos(isForce)
  local contentOffset = self.content.transform.localPosition.y
  if not isForce and self._lastCalOffset == contentOffset then
    return
  end
  local deltaOffset = contentOffset - (self._lastCalOffset or contentOffset)
  self._lastCalOffset = contentOffset
  local centerIndex
  local curCenterY = self.viewPortHeight * 0.5 + contentOffset
  self.tabView:Travel(function(cell)
    local gameObj = cell.gameObject
    if 0 ~= cell.index then
      local pos = gameObj.transform.localPosition
      local circlePos = self.sector:TranformSectorPoint(pos, contentOffset)
      if not circlePos then
        return
      end
      ShareVector3.x, ShareVector3.y, ShareVector3.z = circlePos.x, circlePos.y, 0
      gameObj.transform.localPosition = ShareVector3
    else
      gameObj.transform.localPosition = OutSightVector3
    end
    if self:IsCellCenter(cell, curCenterY) then
      centerIndex = cell.index
    end
  end, false)
  if centerIndex and not isForce then
    self:SetCenterIndex(centerIndex)
  end
end

function LuaSectorScroll:IsCellCenter(cell, curCenterY)
  local isAlignCenter = self.tabView.isAlignCenter
  local gameObj = cell.gameObject
  local cellY = gameObj.transform.localPosition.y
  local index = cell.index
  local cellSize = self.tabView:GetCellSize(index)
  if isAlignCenter then
    cellY = cellY + cellSize * 0.5
  end
  curCenterY = -curCenterY
  if cellY > curCenterY and curCenterY > cellY - cellSize then
    return true
  end
end

function LuaSectorScroll:TweenToCenter(centerIndex)
  local cellSize = self.tabView.tableCellSizeForIndex(self.tabView, centerIndex)
  local offset = self.tabView:GetOffsetByIndex(centerIndex) - self.viewPortHeight * 0.5 + cellSize.y * 0.5
  ShareVector3.x, ShareVector3.y, ShareVector3.z = 0, offset, 0
  CS.UITableviewSpringPosition.StartTween(self.content.gameObject, ShareVector3, 2, false)
end

function LuaSectorScroll:OnEnable()
end

function LuaSectorScroll:LateUpdate()
  if self._isDirty and self.tabView.isReady then
    self._isDirty = false
  end
  self:UpdateCirclePos()
end

function LuaSectorScroll:Update()
end

return LuaSectorScroll
