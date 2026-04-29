_class("InnerGameSortGridHelperRender", Singleton)
InnerGameSortGridHelperRender = InnerGameSortGridHelperRender

function InnerGameSortGridHelperRender:_GetGridEdgePos(pos, direction)
  if pos == nil then
    return nil
  end
  local gridRadius = 0.5
  local edge = gridRadius * Mathf.Sin(Mathf.Rad(45))
  local ret = Vector2(0, 0)
  if direction == "Up" then
    ret.x = pos.x
    ret.y = pos.y + gridRadius
  elseif direction == "Bottom" then
    ret.x = pos.x
    ret.y = pos.y - gridRadius
  elseif direction == "Left" then
    ret.x = pos.x - gridRadius
    ret.y = pos.y
  elseif direction == "Right" then
    ret.x = pos.x + gridRadius
    ret.y = pos.y
  elseif direction == "LeftUp" then
    ret.x = pos.x - gridRadius
    ret.y = pos.y + gridRadius
  elseif direction == "RightUp" then
    ret.x = pos.x + gridRadius
    ret.y = pos.y + gridRadius
  elseif direction == "LeftBottom" then
    ret.x = pos.x - gridRadius
    ret.y = pos.y - gridRadius
  elseif direction == "RightBottom" then
    ret.x = pos.x + gridRadius
    ret.y = pos.y - gridRadius
  end
  return ret
end

function InnerGameSortGridHelperRender:SortGrid(gridList, castPos)
  local leftup, leftbottom, rightbottom, rightup, up, bottom, right, left
  local maxLength = 0
  local leftUpList = {}
  local leftBottomList = {}
  local rightBottomList = {}
  local rightUpList = {}
  local upList = {}
  local bottomList = {}
  local rightList = {}
  local leftList = {}
  local maxGridCount = 0
  for i, pos in pairs(gridList) do
    local dis = pos - castPos
    if maxLength < math.abs(dis.x) then
      maxLength = math.abs(dis.x)
    end
    if maxLength < math.abs(dis.y) then
      maxLength = math.abs(dis.y)
    end
    if 0 < dis.x and 0 > dis.y then
      table.insert(rightBottomList, pos)
      if rightbottom == nil or rightbottom.x < pos.x then
        rightbottom = pos
      end
    elseif 0 > dis.x and 0 > dis.y then
      table.insert(leftBottomList, pos)
      if leftbottom == nil or leftbottom.x > pos.x then
        leftbottom = pos
      end
    elseif 0 > dis.x and 0 < dis.y then
      table.insert(leftUpList, pos)
      if leftup == nil or leftup.x > pos.x then
        leftup = pos
      end
    elseif 0 < dis.x and 0 < dis.y then
      table.insert(rightUpList, pos)
      if rightup == nil or rightup.x < pos.x then
        rightup = pos
      end
    elseif 0 < dis.x and dis.y == 0 then
      table.insert(rightList, pos)
      if right == nil or right.x < pos.x then
        right = pos
      end
    elseif 0 > dis.x and dis.y == 0 then
      table.insert(leftList, pos)
      if left == nil or left.x > pos.x then
        left = pos
      end
    elseif dis.x == 0 and 0 > dis.y then
      table.insert(bottomList, pos)
      if bottom == nil or bottom.y > pos.y then
        bottom = pos
      end
    elseif dis.x == 0 and 0 < dis.y then
      table.insert(upList, pos)
      if up == nil or up.y < pos.y then
        up = pos
      end
    end
  end
  
  local function cmpAscY(pos1, pos2)
    return pos1.y < pos2.y
  end
  
  local function cmpDesY(pos1, pos2)
    return pos1.y > pos2.y
  end
  
  local function cmpAscX(pos1, pos2)
    return pos1.x < pos2.x
  end
  
  local function cmpDesX(pos1, pos2)
    return pos1.x > pos2.x
  end
  
  table.sort(upList, cmpAscY)
  table.sort(bottomList, cmpDesY)
  table.sort(rightList, cmpAscX)
  table.sort(leftList, cmpDesX)
  table.sort(leftUpList, cmpAscY)
  table.sort(rightUpList, cmpAscY)
  table.sort(leftBottomList, cmpDesY)
  table.sort(rightBottomList, cmpDesY)
  
  local function GetMaxGridCount(table, maxGridCount)
    if maxGridCount < #table then
      maxGridCount = #table
    end
    return maxGridCount
  end
  
  maxGridCount = GetMaxGridCount(upList, maxGridCount)
  maxGridCount = GetMaxGridCount(bottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftBottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightBottomList, maxGridCount)
  local targets = {
    {
      gridpos = leftup,
      gridEdgePos = self:_GetGridEdgePos(leftup, "LeftUp"),
      direction = Vector2(-1, 1),
      gridList = leftUpList,
      strDirection = "LeftUp"
    },
    {
      gridpos = leftbottom,
      gridEdgePos = self:_GetGridEdgePos(leftbottom, "LeftBottom"),
      direction = Vector2(-1, -1),
      gridList = leftBottomList,
      strDirection = "LeftBottom"
    },
    {
      gridpos = rightbottom,
      gridEdgePos = self:_GetGridEdgePos(rightbottom, "RightBottom"),
      direction = Vector2(1, -1),
      gridList = rightBottomList,
      strDirection = "RightBottom"
    },
    {
      gridpos = rightup,
      gridEdgePos = self:_GetGridEdgePos(rightup, "RightUp"),
      direction = Vector2(1, 1),
      gridList = rightUpList,
      strDirection = "RightUp"
    },
    {
      gridpos = up,
      gridEdgePos = self:_GetGridEdgePos(up, "Up"),
      direction = Vector2(0, 1),
      gridList = upList,
      strDirection = "Up"
    },
    {
      gridpos = bottom,
      gridEdgePos = self:_GetGridEdgePos(bottom, "Bottom"),
      direction = Vector2(0, -1),
      gridList = bottomList,
      strDirection = "Bottom"
    },
    {
      gridpos = right,
      gridEdgePos = self:_GetGridEdgePos(right, "Right"),
      direction = Vector2(1, 0),
      gridList = rightList,
      strDirection = "Right"
    },
    {
      gridpos = left,
      gridEdgePos = self:_GetGridEdgePos(left, "Left"),
      direction = Vector2(-1, 0),
      gridList = leftList,
      strDirection = "Left"
    }
  }
  return targets, maxLength, maxGridCount
end

function InnerGameSortGridHelperRender:SortGridWithCenterPos(gridList, centerPos)
  local leftup, leftbottom, rightbottom, rightup, up, bottom, right, left, center
  local maxLength = 0
  local leftUpList = {}
  local leftBottomList = {}
  local rightBottomList = {}
  local rightUpList = {}
  local upList = {}
  local bottomList = {}
  local rightList = {}
  local leftList = {}
  local maxGridCount = 0
  for i, pos in pairs(gridList) do
    local dis = pos - centerPos
    if maxLength < math.abs(dis.x) then
      maxLength = math.abs(dis.x)
    end
    if maxLength < math.abs(dis.y) then
      maxLength = math.abs(dis.y)
    end
    if 0 < dis.x and 0 > dis.y then
      table.insert(rightBottomList, pos)
      if rightbottom == nil or rightbottom.x < pos.x then
        rightbottom = pos
      end
    elseif 0 > dis.x and 0 > dis.y then
      table.insert(leftBottomList, pos)
      if leftbottom == nil or leftbottom.x > pos.x then
        leftbottom = pos
      end
    elseif 0 > dis.x and 0 < dis.y then
      table.insert(leftUpList, pos)
      if leftup == nil or leftup.x > pos.x then
        leftup = pos
      end
    elseif 0 < dis.x and 0 < dis.y then
      table.insert(rightUpList, pos)
      if rightup == nil or rightup.x < pos.x then
        rightup = pos
      end
    elseif 0 < dis.x and dis.y == 0 then
      table.insert(rightList, pos)
      if right == nil or right.x < pos.x then
        right = pos
      end
    elseif 0 > dis.x and dis.y == 0 then
      table.insert(leftList, pos)
      if left == nil or left.x > pos.x then
        left = pos
      end
    elseif dis.x == 0 and 0 > dis.y then
      table.insert(bottomList, pos)
      if bottom == nil or bottom.y > pos.y then
        bottom = pos
      end
    elseif dis.x == 0 and 0 < dis.y then
      table.insert(upList, pos)
      if up == nil or up.y < pos.y then
        up = pos
      end
    else
      center = pos
    end
  end
  
  local function cmpAscY(pos1, pos2)
    return pos1.y < pos2.y
  end
  
  local function cmpDesY(pos1, pos2)
    return pos1.y > pos2.y
  end
  
  local function cmpAscX(pos1, pos2)
    return pos1.x < pos2.x
  end
  
  local function cmpDesX(pos1, pos2)
    return pos1.x > pos2.x
  end
  
  table.sort(upList, cmpAscY)
  table.sort(bottomList, cmpDesY)
  table.sort(rightList, cmpAscX)
  table.sort(leftList, cmpDesX)
  table.sort(leftUpList, cmpAscY)
  table.sort(rightUpList, cmpAscY)
  table.sort(leftBottomList, cmpDesY)
  table.sort(rightBottomList, cmpDesY)
  
  local function GetMaxGridCount(table, maxGridCount)
    if maxGridCount < #table then
      maxGridCount = #table
    end
    return maxGridCount
  end
  
  maxGridCount = GetMaxGridCount(upList, maxGridCount)
  maxGridCount = GetMaxGridCount(bottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftBottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightBottomList, maxGridCount)
  if center then
    maxGridCount = GetMaxGridCount({center}, maxGridCount)
  end
  local targets = {
    {
      gridpos = leftup,
      gridEdgePos = self:_GetGridEdgePos(leftup, "LeftUp"),
      direction = Vector2(-1, 1),
      gridList = leftUpList,
      strDirection = "LeftUp"
    },
    {
      gridpos = leftbottom,
      gridEdgePos = self:_GetGridEdgePos(leftbottom, "LeftBottom"),
      direction = Vector2(-1, -1),
      gridList = leftBottomList,
      strDirection = "LeftBottom"
    },
    {
      gridpos = rightbottom,
      gridEdgePos = self:_GetGridEdgePos(rightbottom, "RightBottom"),
      direction = Vector2(1, -1),
      gridList = rightBottomList,
      strDirection = "RightBottom"
    },
    {
      gridpos = rightup,
      gridEdgePos = self:_GetGridEdgePos(rightup, "RightUp"),
      direction = Vector2(1, 1),
      gridList = rightUpList,
      strDirection = "RightUp"
    },
    {
      gridpos = up,
      gridEdgePos = self:_GetGridEdgePos(up, "Up"),
      direction = Vector2(0, 1),
      gridList = upList,
      strDirection = "Up"
    },
    {
      gridpos = bottom,
      gridEdgePos = self:_GetGridEdgePos(bottom, "Bottom"),
      direction = Vector2(0, -1),
      gridList = bottomList,
      strDirection = "Bottom"
    },
    {
      gridpos = right,
      gridEdgePos = self:_GetGridEdgePos(right, "Right"),
      direction = Vector2(1, 0),
      gridList = rightList,
      strDirection = "Right"
    },
    {
      gridpos = left,
      gridEdgePos = self:_GetGridEdgePos(left, "Left"),
      direction = Vector2(-1, 0),
      gridList = leftList,
      strDirection = "Left"
    },
    {
      gridpos = center,
      gridEdgePos = center,
      direction = Vector2(0, 0),
      gridList = {center},
      strDirection = "Center"
    }
  }
  return targets, maxLength, maxGridCount
end
