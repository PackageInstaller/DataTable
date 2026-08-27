local Game2048Board = class("Game2048Board")
local Game2048Config = require("Game.TinyGames.2048.Config.Game2048Config")

function Game2048Board:ctor()
  self.xCount = Game2048Config.sizeX
  self.yCount = Game2048Config.sizeY
end

function Game2048Board:InitGame2048Board()
  self.cells = {}
  for i = 1, self.xCount do
    self.cells[i] = {}
  end
  self._random = CS.FixRandom(math.random(100, CommonUtil.Int32Max))
end

function Game2048Board:RandomAvailableCell()
  local emptyCount = self:GetAvailableCellCount()
  if emptyCount == 0 then
    return false
  end
  local index = self._random:RandUInt(0, emptyCount)
  emptyCount = 0
  for x = 1, self.xCount do
    for y = 1, self.yCount do
      local cell = self.cells[x][y]
      if cell == nil then
        if emptyCount == index then
          return true, x, y
        end
        emptyCount = emptyCount + 1
      end
    end
  end
  return false
end

function Game2048Board:GetAvailableCellCount()
  local emptyCount = 0
  for x = 1, self.xCount do
    for y = 1, self.yCount do
      local cell = self.cells[x][y]
      if cell == nil then
        emptyCount = emptyCount + 1
      end
    end
  end
  return emptyCount
end

function Game2048Board:GetRandomNumLevel()
  local value = self._random:RandUInt(0, 10)
  if value < 9 then
    return 1
  else
    return 2
  end
end

function Game2048Board:WithinBounds(x, y)
  return 1 <= x and x <= self.xCount and 1 <= y and y <= self.yCount
end

function Game2048Board:CellContent(x, y)
  if self:WithinBounds(x, y) then
    return self.cells[x][y]
  else
    return nil
  end
end

function Game2048Board:CellContentDirect(x, y)
  return self.cells[x][y]
end

function Game2048Board:InsertTile(tile)
  self.cells[tile.x][tile.y] = tile
end

function Game2048Board:RemoveTile(tile)
  self.cells[tile.x][tile.y] = nil
end

function Game2048Board:CellAvailable(x, y)
  return not self:CellOccupied(x, y)
end

function Game2048Board:CellOccupied(x, y)
  return self:CellContent(x, y) ~= nil
end

return Game2048Board
