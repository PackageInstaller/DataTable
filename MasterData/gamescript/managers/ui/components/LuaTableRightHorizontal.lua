local LuaTableRightHorizontal = NewClass("LuaTableRightHorizontal")
local T_UITableview = typeof(CS.UITableview)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local SharedVector2 = CS.UnityEngine.Vector2(0, 0)

function LuaTableRightHorizontal:ctor(container)
  self.tabView = container:GetComponent(T_UITableview)
  self.container = container
  self:RightHorizontal()
end

function LuaTableRightHorizontal:RightHorizontal()
  local numberCellsInTableview = self.tabView.numberCellsInTableview
  local tableCellSizeForIndex = self.tabView.tableCellSizeForIndex
  local reloadFinishCallback = self.tabView.reloadFinishCallback
  local cellSize = tableCellSizeForIndex(self.tabView, 0)
  local w = cellSize.x
  local preOffsetX, preOffsetY = self.tabView.cellOffset.x, self.tabView.cellOffset.y
  local cellSpaceX = self.tabView.cellSpacing.x
  local miniShowCount = self.container.transform.sizeDelta.x / (w + cellSpaceX)
  
  function self.tabView.numberCellsInTableview()
    local dataCount = numberCellsInTableview(self.tabView)
    if dataCount < miniShowCount then
      local offsetX = (miniShowCount - dataCount) * (w + cellSpaceX)
      SharedVector2.x = preOffsetX + offsetX
      SharedVector2.y = preOffsetY
      self.tabView.cellOffset = SharedVector2
    end
    return dataCount
  end
  
  local isFirstReload = true
  
  function self.tabView.reloadFinishCallback()
    if isFirstReload then
      self.tabView:MoveCellInView(0)
      isFirstReload = false
    end
    if reloadFinishCallback then
      reloadFinishCallback()
    end
  end
end

return LuaTableRightHorizontal
