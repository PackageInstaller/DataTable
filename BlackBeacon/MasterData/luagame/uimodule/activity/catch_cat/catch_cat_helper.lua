local CatchCatNode = require("uimodule.activity.catch_cat.catch_cat_node")
local all_activity_cfg = ShareRes.create("activity.kitten_escape")
local all_grid_cfg = ShareRes.create("activity.kitten_escape_grid")

local function calculateHeuristic(node, goal_pos)
  return math.abs(node.x - goal_pos[1]) + math.abs(node.y - goal_pos[2])
end

local function calculateMinHeuristic(node, goals)
  local minHeuristic = math.huge
  for _, goal_pos in ipairs(goals) do
    local heuristic = calculateHeuristic(node, goal_pos)
    if minHeuristic > heuristic then
      minHeuristic = heuristic
    end
  end
  return minHeuristic
end

local odd_direction = {
  {1, 0},
  {-1, 0},
  {0, 1},
  {0, -1},
  {-1, 1},
  {1, 1}
}
local even_direction = {
  {1, 0},
  {-1, 0},
  {0, 1},
  {0, -1},
  {-1, -1},
  {1, -1}
}

local function getNeighbors(node, grid)
  local neighbors = {}
  local directions = 1 == node.x % 2 and odd_direction or even_direction
  for _, dir in ipairs(directions) do
    local nx = node.x + dir[1]
    local ny = node.y + dir[2]
    if grid[nx] and grid[nx][ny] then
      table.insert(neighbors, grid[nx][ny])
    end
  end
  return neighbors
end

local function astar(grid, start, goals)
  local startNode = grid[start[1]][start[2]]
  local openSet = {}
  local closedSet = {}
  table.insert(openSet, startNode)
  while #openSet > 0 do
    local current = openSet[1]
    local currentIndex = 1
    for i, node in ipairs(openSet) do
      if node.f < current.f then
        current = node
        currentIndex = i
      end
    end
    for _, goal_pos in ipairs(goals) do
      if current.x == goal_pos[1] and current.y == goal_pos[2] then
        local path = {}
        while current do
          table.insert(path, 1, current)
          current = current.parent
        end
        return path
      end
    end
    table.remove(openSet, currentIndex)
    table.insert(closedSet, current)
    for _, neighbor in ipairs(getNeighbors(current, grid)) do
      if not neighbor.walkable then
      else
        local inClosedSet = false
        for _, closedNode in ipairs(closedSet) do
          if neighbor.x == closedNode.x and neighbor.y == closedNode.y then
            inClosedSet = true
            break
          end
        end
        if inClosedSet then
        else
          local tentativeG = current.g + 1
          local inOpenSet = false
          for _, openNode in ipairs(openSet) do
            if neighbor.x == openNode.x and neighbor.y == openNode.y then
              inOpenSet = true
              if tentativeG < neighbor.g then
                neighbor.g = tentativeG
                neighbor.parent = current
                neighbor.f = neighbor.g + neighbor.h
              end
              break
            end
          end
          if not inOpenSet then
            neighbor.g = tentativeG
            neighbor.h = calculateMinHeuristic(neighbor, goals)
            neighbor.f = neighbor.g + neighbor.h
            neighbor.parent = current
            table.insert(openSet, neighbor)
          end
        end
      end
    end
  end
  return nil
end

local function createGrid(n, m, default_cfg)
  local grid = {}
  for row = 1, n do
    grid[row] = {}
    for column = 1, m do
      grid[row][column] = CatchCatNode:new(row, column, default_cfg)
    end
  end
  return grid
end

local helper = {}

function helper.create_grid(stage_cfg)
  local grid_group_cfg = all_grid_cfg[stage_cfg.GridGroup]
  local dafault_grid_cfg = {
    Type = Config.CATCH_CAT_GRID_TYPE.DEFAULT,
    ActivityId = stage_cfg.ActivityId,
    Id = stage_cfg.Id
  }
  local goals = {}
  local grid = createGrid(stage_cfg.Rownum, stage_cfg.ColumnNum, dafault_grid_cfg)
  for _, v in pairs(grid_group_cfg) do
    local row = v.Pos[1]
    local column = v.Pos[2]
    if not grid[row] or not grid[row][column] then
      Log.Error("格子配置超出关卡定义行列范围,格子Id：", v.Id)
    else
      grid[row][column]:set_cfg(v)
    end
    if v.Type == Config.CATCH_CAT_GRID_TYPE.EXIT then
      goals[#goals + 1] = v.Pos
    end
  end
  if next(goals) == nil then
    Log.Error("格子组未配置出口,组id:", stage_cfg.GridGroup)
    return
  end
  return grid, goals
end

function helper.get_shortest_path(grid, start, goals)
  grid = UtilTable.copy_table(grid)
  return astar(grid, start, goals)
end

return helper
