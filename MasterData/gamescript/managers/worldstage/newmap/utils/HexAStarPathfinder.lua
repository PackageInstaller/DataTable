local WorldStageConst = require("Managers.WorldStage.WorldStageConst")
local HexAStarPathfinder = {}

function HexAStarPathfinder.GetNeighborOffsets(y)
  local view = WorldStageConst.EvenView[1]
  if 1 == y % 2 then
    view = WorldStageConst.OddView[1]
  end
  local offsets = {}
  for _, offset in ipairs(view) do
    if 0 ~= offset[1] or 0 ~= offset[2] then
      table.insert(offsets, offset)
    end
  end
  return offsets
end

function HexAStarPathfinder.Heuristic(x1, y1, x2, y2)
  local dx = x2 - x1
  local dy = y2 - y1
  if 1 == y1 % 2 ~= (1 == y2 % 2) then
    if dx > 0 then
      dx = dx - 0.5
    else
      dx = dx + 0.5
    end
  end
  return math.abs(dx) + math.abs(dy)
end

local function getKey(x, y)
  return x * 1000 + y
end

local function reconstructPath(cameFrom, startX, startY, endX, endY)
  local path = {}
  local node = {x = endX, y = endY}
  table.insert(path, node)
  local key = getKey(node.x, node.y)
  local startKey = getKey(startX, startY)
  while cameFrom[key] and key ~= startKey do
    node = cameFrom[key]
    table.insert(path, 1, node)
    key = getKey(node.x, node.y)
  end
  return path
end

local function findInSet(set, x, y)
  local key = getKey(x, y)
  for _, node in ipairs(set) do
    if node.key == key then
      return node
    end
  end
  return nil
end

local function popLowestFScoreNode(openSet, fScore)
  local current
  local currentIndex = 1
  local minF = math.huge
  for i, node in ipairs(openSet) do
    local f = fScore[node.key] or math.huge
    if minF > f then
      minF = f
      current = node
      currentIndex = i
    end
  end
  if not current then
    return nil
  end
  table.remove(openSet, currentIndex)
  return current
end

function HexAStarPathfinder.FindPath(startX, startY, endX, endY, isWalkableFunc, mapWidth, mapHeight)
  if not isWalkableFunc then
    Logger.Error("HexAStarPathfinder.FindPath: isWalkableFunc is required")
    return nil
  end
  if mapWidth and mapHeight and (endX < 1 or mapWidth < endX or endY < 1 or mapHeight < endY) then
    Logger.Warn("目标位置超出边界:", endX, endY)
    return nil
  end
  if not isWalkableFunc(endX, endY) then
    Logger.Warn("目标位置不可通行:", endX, endY)
    return nil
  end
  if startX == endX and startY == endY then
    return {
      {x = startX, y = startY}
    }
  end
  local neighborOffsets = HexAStarPathfinder.GetNeighborOffsets(startY)
  for _, offset in ipairs(neighborOffsets) do
    local nx = startX + offset[1]
    local ny = startY + offset[2]
    if nx == endX and ny == endY and isWalkableFunc(nx, ny) then
      return {
        {x = startX, y = startY},
        {x = endX, y = endY}
      }
    end
  end
  local openSet = {}
  local closedSet = {}
  local cameFrom = {}
  local gScore = {}
  local fScore = {}
  local startKey = getKey(startX, startY)
  gScore[startKey] = 0
  fScore[startKey] = HexAStarPathfinder.Heuristic(startX, startY, endX, endY)
  table.insert(openSet, {
    x = startX,
    y = startY,
    key = startKey
  })
  while #openSet > 0 do
    local current = popLowestFScoreNode(openSet, fScore)
    if not current then
      break
    end
    if current.x == endX and current.y == endY then
      do return reconstructPath, cameFrom, startX, startY, endX end
      return reconstructPath, cameFrom, startX, startY, endX, endY, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    closedSet[current.key] = true
    local currentNeighborOffsets = HexAStarPathfinder.GetNeighborOffsets(current.y)
    for _, offset in ipairs(currentNeighborOffsets) do
      local neighborX = current.x + offset[1]
      local neighborY = current.y + offset[2]
      local neighborKey = getKey(neighborX, neighborY)
      if mapWidth and mapHeight and (neighborX < 1 or mapWidth < neighborX or neighborY < 1 or mapHeight < neighborY) then
      elseif not isWalkableFunc(neighborX, neighborY) then
      elseif closedSet[neighborKey] then
      else
        local tentativeGScore = (gScore[current.key] or math.huge) + 1
        local neighborNode = findInSet(openSet, neighborX, neighborY)
        if not neighborNode then
          neighborNode = {
            x = neighborX,
            y = neighborY,
            key = neighborKey
          }
          table.insert(openSet, neighborNode)
        elseif tentativeGScore >= (gScore[neighborKey] or math.huge) then
          goto lbl_244
        end
        cameFrom[neighborKey] = {
          x = current.x,
          y = current.y
        }
        gScore[neighborKey] = tentativeGScore
        fScore[neighborKey] = tentativeGScore + HexAStarPathfinder.Heuristic(neighborX, neighborY, endX, endY)
      end
      ::lbl_244::
    end
  end
  Logger.Warn("无法找到路径从", startX, startY, "到", endX, endY)
  return nil
end

return HexAStarPathfinder
