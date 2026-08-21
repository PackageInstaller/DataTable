require("board_svc_l")
local AttackAreaType = {PlayerArea = 1, AIArea = 2}
_enum("AttackAreaType", AttackAreaType)
local GenBoardMode = {
  Generated = 0,
  Specified = 1,
  Guide = 2,
  Archived = 3,
  BigBoard = 4
}
_enum("GenBoardMode", GenBoardMode)

local function RightRotate(arr)
  local brr = {}
  local n = #arr
  for y = 1, n do
    local t = {}
    table.insert(brr, t)
    for x = n, 1, -1 do
      table.insert(t, arr[x][y])
    end
  end
  return brr
end

local RoomPrototype = {
  [1000] = 1,
  [100] = 1,
  [10] = 1,
  [1] = 1,
  [1100] = 2,
  [110] = 2,
  [11] = 2,
  [1001] = 2,
  [1010] = 3,
  [101] = 3,
  [1110] = 4,
  [111] = 4,
  [1011] = 4,
  [1101] = 4,
  [1111] = 5
}
local RotateTable = {
  [1000] = 0,
  [100] = 1,
  [10] = 2,
  [1] = 3,
  [1100] = 0,
  [110] = 1,
  [11] = 2,
  [1001] = 3,
  [1010] = 0,
  [101] = 1,
  [1110] = 0,
  [111] = 1,
  [1011] = 2,
  [1101] = 3,
  [1111] = 0
}
local PointRightRotateTable = {
  [101] = 501,
  [201] = 502,
  [301] = 503,
  [401] = 504,
  [501] = 505,
  [102] = 401,
  [202] = 402,
  [302] = 403,
  [402] = 404,
  [502] = 405,
  [103] = 301,
  [203] = 302,
  [303] = 303,
  [403] = 304,
  [503] = 305,
  [104] = 201,
  [204] = 202,
  [304] = 203,
  [404] = 204,
  [504] = 205,
  [105] = 101,
  [205] = 102,
  [305] = 103,
  [405] = 104,
  [505] = 105
}
local DirRightRotateTable = {
  [12] = 21,
  [21] = 10,
  [10] = 1,
  [1] = 12,
  [2] = 22,
  [22] = 20,
  [20] = 0,
  [0] = 2
}
local BigBoardRoomSize = 5

local function Filter_MatchGAndGrid(g, filter_grid)
  return CanMatchPieceType(g.color, filter_grid.color)
end

function BoardServiceLogic:_RightRotatePoint(x, y, cnt)
  if cnt == 0 then
    return x, y
  end
  local val = x * 100 + y
  for i = 1, cnt do
    val = PointRightRotateTable[val]
  end
  x = val // 100
  y = val % 100
  return x, y
end

function BoardServiceLogic:_RightRotateDir(x, y, cnt)
  if cnt == 0 then
    return x, y
  end
  local val = (x + 1) * 10 + y + 1
  for i = 1, cnt do
    val = DirRightRotateTable[val]
  end
  x = val // 10 - 1
  y = val % 10 - 1
  return x, y
end

function BoardServiceLogic:_BigBoardRandRoom(cells, cx, cy)
  local adj = {
    0,
    0,
    0,
    0
  }
  if cells[cx] and cells[cx][cy + 1] and cells[cx][cy + 1] ~= 0 then
    adj[1] = 1
  end
  if cells[cx + 1] and cells[cx + 1][cy] and cells[cx + 1][cy] ~= 0 then
    adj[2] = 1
  end
  if cells[cx] and cells[cx][cy - 1] and cells[cx][cy - 1] ~= 0 then
    adj[3] = 1
  end
  if cells[cx - 1] and cells[cx - 1][cy] and cells[cx - 1][cy] ~= 0 then
    adj[4] = 1
  end
  local val = adj[1] * 1000 + adj[2] * 100 + adj[3] * 10 + adj[4] * 1
  local rotateCnt = RotateTable[val]
  local roomtype = RoomPrototype[val]
  local cfgs = Cfg.cfg_board_big_room({RoomType = roomtype})
  local randomSvc = self._world:GetService("RandomLogic")
  local r = randomSvc:LogicRand(1, #cfgs)
  local roomcfg = cfgs[r]
  local grids = roomcfg.RoomGrid
  for i = 1, rotateCnt do
    grids = RightRotate(grids)
  end
  local role, traps, monsters
  if roomcfg.Role then
    role = table.clone(roomcfg.Role)
    role.Pos[1], role.Pos[2] = self:_RightRotatePoint(role.Pos[1], role.Pos[2], rotateCnt)
    role.Dir[1], role.Dir[2] = self:_RightRotateDir(role.Dir[1], role.Dir[2], rotateCnt)
  end
  if roomcfg.Traps then
    traps = table.clone(roomcfg.Traps)
    for _, v in ipairs(traps) do
      v.Pos[1], v.Pos[2] = self:_RightRotatePoint(v.Pos[1], v.Pos[2], rotateCnt)
      v.Dir[1], v.Dir[2] = self:_RightRotateDir(v.Dir[1], v.Dir[2], rotateCnt)
    end
  end
  if roomcfg.Monsters then
    monsters = table.clone(roomcfg.Monsters)
    for _, v in ipairs(monsters) do
      v.Pos[1], v.Pos[2] = self:_RightRotatePoint(v.Pos[1], v.Pos[2], rotateCnt)
      v.Dir[1], v.Dir[2] = self:_RightRotateDir(v.Dir[1], v.Dir[2], rotateCnt)
    end
  end
  Log.error("[gen board] cx=", cx, "cy=", cy, "val=", val, "roll=", rotateCnt, "roomtype=", roomtype, "roomcfg.id=", roomcfg.ID)
  return grids, role, traps, monsters
end

function BoardServiceLogic:_BigBoardFixedRoom(cellID)
  local cellCfg = Cfg.cfg_board_big_room[cellID]
  local grids = cellCfg.RoomGrid
  local role = cellCfg.Role
  local traps = cellCfg.Traps
  local monsters = cellCfg.Monsters
  return grids, role, traps, monsters
end

function BoardServiceLogic:GetCurBoardMaxX()
  return self._defaultMaxX or BattleConst.DefaultMaxX
end

function BoardServiceLogic:GetCurBoardMaxY()
  return self._defaultMaxY or BattleConst.DefaultMaxY
end

function BoardServiceLogic:GetCurBoardMaxLen()
  local maxX = self:GetCurBoardMaxX()
  local maxY = self:GetCurBoardMaxY()
  return maxX > maxY and maxX or maxY
end

function BoardServiceLogic:_SetCurBoardCfgInfo()
  if self._boardConfig then
    self._defaultMaxX = self._boardConfig.DefaultMaxX and self._boardConfig.DefaultMaxX or BattleConst.DefaultMaxX
    self._defaultMaxY = self._boardConfig.DefaultMaxY and self._boardConfig.DefaultMaxY or BattleConst.DefaultMaxY
    BattleConst.BoardMaxLen = math.max(self._defaultMaxX, self._defaultMaxY)
    self._defaultPlayerAreaSizeX = BattleConst.DefaultPlayerAreaSize
    self._defaultPlayerAreaSizeY = BattleConst.DefaultPlayerAreaSize
    if self._boardConfig.DefaultPlayerAreaSize and type(self._boardConfig.DefaultPlayerAreaSize) == "table" and #self._boardConfig.DefaultPlayerAreaSize == 2 then
      self._defaultPlayerAreaSizeX = self._boardConfig.DefaultPlayerAreaSize[1]
      self._defaultPlayerAreaSizeY = self._boardConfig.DefaultPlayerAreaSize[2]
    end
    self._defaultAIAreaSizeX = BattleConst.DefaultAIAreaSize
    self._defaultAIAreaSizeY = BattleConst.DefaultAIAreaSize
    if self._boardConfig.DefaultAIAreaSize and type(self._boardConfig.DefaultAIAreaSize) == "table" and #self._boardConfig.DefaultAIAreaSize == 2 then
      self._defaultAIAreaSizeX = self._boardConfig.DefaultAIAreaSize[1]
      self._defaultAIAreaSizeY = self._boardConfig.DefaultAIAreaSize[2]
    end
    if self.PlayerArea then
      self.PlayerArea.maxX = self._defaultPlayerAreaSizeX
      self.PlayerArea.maxY = self._defaultPlayerAreaSizeY
    end
    if self.AIArea then
      self.AIArea.maxX = self._defaultAIAreaSizeX
      self.AIArea.maxY = self._defaultAIAreaSizeY
    end
    self:_GenBoardRingMax()
  end
end

function BoardServiceLogic:_GenBoardRingMax()
  self._ringMax = {}
  local maxX = self:GetCurBoardMaxX()
  local maxY = self:GetCurBoardMaxY()
  local maxLen = self:GetCurBoardMaxLen()
  
  local function pushPos(posX, posY)
    if posX >= -maxX and posX <= maxX and posY >= -maxY and posY <= maxY then
      local pos = {posX, posY}
      table.insert(self._ringMax, pos)
    end
  end
  
  for ringNum = 1, maxLen do
    for posY = -ringNum, ringNum do
      pushPos(-ringNum, posY)
    end
    for posX = -(ringNum - 1), ringNum - 1 do
      pushPos(posX, -ringNum)
      pushPos(posX, ringNum)
    end
    for posY = -ringNum, ringNum do
      pushPos(ringNum, posY)
    end
  end
end

function BoardServiceLogic:GetCurBoardRingMax()
  if self._ringMax then
    return self._ringMax
  else
    return Ring9
  end
end

function BoardServiceLogic:GenerateBoard(boardId, teamEntity)
  self.GridTiles = {}
  self._gridArray = {}
  self.MonsterArea = {}
  self.TrapArea = {}
  self.RoleArea = {}
  self._connectRate = 0
  self._totalConnect = 0
  self._totalGridCnt = 0
  self._boardConfig = Cfg.cfg_board[boardId]
  self:_SetCurBoardCfgInfo()
  self._genPieceTotalWeight = 0
  local generatePieceWeight = self:GetCurBoardGeneratePieceWeight()
  for i = 1, #generatePieceWeight do
    self._genPieceTotalWeight = self._genPieceTotalWeight + generatePieceWeight[i]
  end
  local levelConfigData = self._configService:GetLevelConfigData()
  self.RoleArea.Pos = levelConfigData:GetPlayerBornPos()
  self.RoleArea.Dir = levelConfigData:GetPlayerBornRotation()
  if teamEntity then
    self.RoleArea.Pos = table.cloneconf(teamEntity:GetGridPosition())
    self.RoleArea.Dir = table.cloneconf(teamEntity:GetGridDirection())
  end
  if self._boardConfig.BoardMode == GenBoardMode.BigBoard then
    local cfg = Cfg.cfg_board_big_cell[self._boardConfig.BigBoard]
    local cells = cfg.BigBoardCells
    local fixCells = cfg.FixCells or {}
    for cx, row in ipairs(cells) do
      for cy, cellType in ipairs(row) do
        local grids, role, traps, monsters
        if cellType == 1 then
          grids, role, traps, monsters = self:_BigBoardRandRoom(cells, cx, cy)
        elseif cellType == 2 then
          local cellID = 1
          for i, v in ipairs(fixCells) do
            if v.Pos[1] == cx and v.Pos[2] == cy then
              cellID = v.CellID
            end
          end
          grids, role, traps, monsters = self:_BigBoardFixedRoom(cellID)
        end
        if grids then
          local basex = BigBoardRoomSize * (cx - 1)
          local basey = BigBoardRoomSize * (cy - 1)
          if role then
            self.RoleArea = {
              Pos = Vector2(basex + role.Pos[1], basey + role.Pos[2]),
              Dir = Vector2(role.Dir[1], role.Dir[2])
            }
          end
          for ox, row in ipairs(grids) do
            for oy, gt in ipairs(row) do
              local x = ox + basex
              local y = oy + basey
              if not self.GridTiles[x] then
                self.GridTiles[x] = {}
              end
              if gt == 1 then
                local offset = math.abs(x - self.RoleArea.Pos.x) + math.abs(y - self.RoleArea.Pos.y)
                local val = BattleConst.BoardGenConnectRateParamTable[offset]
                self.GridTiles[x][y] = {
                  x = x,
                  y = y,
                  connect = 0,
                  color = PieceType.None,
                  connvalue = val
                }
                table.insert(self._gridArray, self.GridTiles[x][y])
              end
            end
          end
          if traps then
            for _, trap in ipairs(traps) do
              local t = {
                ID = trap.TrapID,
                Pos = Vector2(basex + trap.Pos[1], basey + trap.Pos[2]),
                Dir = Vector2(trap.Dir[1], trap.Dir[2])
              }
              table.insert(self.TrapArea, t)
            end
          end
          if monsters then
            for _, monster in ipairs(monsters) do
              local t = {
                ID = monster.MonsterID,
                Pos = Vector2(basex + monster.Pos[1], basey + monster.Pos[2]),
                Dir = Vector2(monster.Dir[1], monster.Dir[2])
              }
              table.insert(self.MonsterArea, t)
            end
          end
        end
      end
    end
  else
    local maxX = self:GetCurBoardMaxX()
    local maxY = self:GetCurBoardMaxY()
    for x = 1, maxX do
      self.GridTiles[x] = {}
      for y = 1, maxY do
        local offset = math.abs(x - self.RoleArea.Pos.x) + math.abs(y - self.RoleArea.Pos.y) + 1
        local val = BattleConst.BoardGenConnectRateParamTable[offset]
        assert(val ~= nil, "offset=" .. offset)
        self.GridTiles[x][y] = {
          x = x,
          y = y,
          connect = 0,
          color = PieceType.None,
          connvalue = val
        }
        table.insert(self._gridArray, self.GridTiles[x][y])
      end
    end
    for _, v in ipairs(self.GapTiles) do
      local x, y = v[1], v[2]
      self.GridTiles[x][y] = nil
    end
  end
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) ~= MatchType.MT_PopStar and self._world:MatchType(GetMatchTypeType.NoLinkLine) ~= MatchType.MT_PopStarPro then
    self._roleGrid = self.GridTiles[self.RoleArea.Pos.x][self.RoleArea.Pos.y]
  end
  local boardMode = self._boardConfig.BoardMode
  local pieces
  local archive = self._world:GetService("Maze"):GetBattleArchive()
  if archive then
    boardMode = GenBoardMode.Archived
    pieces = archive.pieces
  end
  if boardMode == GenBoardMode.Generated then
    self:GeneratedColor()
  elseif boardMode == GenBoardMode.Specified then
    self:SpecifiedColor(self._boardConfig.SpecifiedBoard)
  elseif boardMode == GenBoardMode.Guide then
    self:SpecifiedColor(self._boardConfig.SpecifiedBoard)
  elseif boardMode == GenBoardMode.Archived then
    self:SpecifiedColor(pieces)
  elseif boardMode == GenBoardMode.BigBoard then
    self:GeneratedColor()
  end
  if boardMode ~= GenBoardMode.Archived and self._roleGrid then
    self._roleGrid.color = PieceType.None
  end
  local supplyPieceWeight = table.cloneconf(self._boardConfig.SupplyPieceWeight)
  supplyPieceWeight = self:ProcessSupplyPieceWeight(supplyPieceWeight)
  self:CalculateSupplyPieceWeights(supplyPieceWeight)
  if self._extraBoardPosList then
    for i = 1, #self._extraBoardPosList do
      local x = self._extraBoardPosList[i][1]
      local y = self._extraBoardPosList[i][2]
      if not self.GridTiles[x] then
        self.GridTiles[x] = {}
      end
      if not self.GridTiles[x][y] then
        self.GridTiles[x][y] = {}
      end
      self.GridTiles[x][y] = {
        x = x,
        y = y,
        connect = 0,
        color = PieceType.None,
        connvalue = 0
      }
    end
  end
  return self.GridTiles
end

function BoardServiceLogic:SetGapTilesBlock()
  local boardEntity = self._world:GetBoardEntity()
  local blockFlags = boardEntity:Board():GetBlockFlagArray()
  local mapGapTiles = self.GapTiles
  local sBoard = self._world:GetService("BoardLogic")
  local cfgId = BattleConst.BlockFlagCfgIDGapTile
  local blockFlag = sBoard:GetBlockFlagByBlockId(cfgId)
  for _, v in ipairs(mapGapTiles) do
    local block = PieceBlockData:New(v[1], v[2])
    block:AddBlock(-cfgId, blockFlag)
    blockFlags[v[1]][v[2]] = block
  end
end

function BoardServiceLogic:ModifyPieceWeight(piece_type, weight, flag)
  self._supplyPieceWeights[piece_type]:AddModify(weight, flag)
  self._supplyPieceTotalWeight:AddModify(weight, flag)
end

function BoardServiceLogic:RemoveModifyPieceWeight(piece_type, flag)
  self._supplyPieceWeights[piece_type]:RemoveModify(flag)
  self._supplyPieceTotalWeight:RemoveModify(flag)
end

function BoardServiceLogic:SpecifiedColor(board)
  for x, row in pairs(board) do
    for y, color in pairs(row) do
      if self.GridTiles[x][y] then
        self.GridTiles[x][y].color = color
        self:AddGridColor(self.GridTiles[x][y])
      end
    end
  end
end

function BoardServiceLogic:GetConnectRate()
  return self._connectRate
end

function BoardServiceLogic:GeneratedColor()
  self:GenColorPool(51)
  self:GenIslandPool()
  self:GrowIslandPool()
  self:FillRestGridColor()
  self:AdjustConnectRate(self._boardConfig.ConnectRate)
end

function BoardServiceLogic:GenColorPool(maxGridNum)
  local pool = {}
  local generatePieceAmount = self:GetCurBoardGeneratePieceAmount()
  pool[PieceType.Blue] = generatePieceAmount[PieceType.Blue] or 0
  pool[PieceType.Red] = generatePieceAmount[PieceType.Red] or 0
  pool[PieceType.Green] = generatePieceAmount[PieceType.Green] or 0
  pool[PieceType.Yellow] = generatePieceAmount[PieceType.Yellow] or 0
  pool[PieceType.Any] = generatePieceAmount[PieceType.Any] or 0
  local sum = 0
  for i, v in ipairs(pool) do
    sum = sum + v
  end
  local rest = maxGridNum - sum
  for i = 0, rest do
    local color = self:GenGridColorByWeight()
    pool[color] = pool[color] + 1
  end
  self._colorPool = pool
  return pool
end

function BoardServiceLogic:GenGridColorByWeight()
  local randomRes = self:GetBoardRandomNumber(1, self._genPieceTotalWeight)
  local weight = 0
  local generatePieceWeight = self:GetCurBoardGeneratePieceWeight()
  for i = 1, #generatePieceWeight do
    weight = weight + generatePieceWeight[i]
    if randomRes <= weight then
      return i
    end
  end
end

function BoardServiceLogic:FillGridColorByWeight()
  local randomRes = self:GetBoardRandomNumber(1, self._supplyPieceTotalWeight:Value())
  local weight = 0
  for i = 1, #self._supplyPieceWeights do
    weight = weight + self._supplyPieceWeights[i]:Value()
    if randomRes <= weight then
      return i
    end
  end
end

function BoardServiceLogic:GetRoundGrid(grid, filter, ...)
  local roundGrids = {}
  if grid == nil then
    return roundGrids
  end
  for x = -1, 1 do
    for y = -1, 1 do
      local pos = Vector2(grid.x + x, grid.y + y)
      if (x ~= 0 or y ~= 0) and self.GridTiles[pos.x] and self.GridTiles[pos.x][pos.y] then
        local g = self.GridTiles[pos.x][pos.y]
        if filter == nil or filter(g, ...) then
          table.insert(roundGrids, g)
        end
      end
    end
  end
  return roundGrids
end

function BoardServiceLogic:GenIslandPool()
  self._initIslands = {}
  if self._boardConfig.RoundIslandCount > 8 then
    self._boardConfig.RoundIslandCount = 8
  end
  local baseGrid = self._roleGrid
  if self._world:SubMatchType() == MatchType.MT_PopStar or self._world:SubMatchType() == MatchType.MT_PopStarPro then
    baseGrid = self.GridTiles[self.RoleArea.Pos.x][self.RoleArea.Pos.y]
  end
  local round = self:GetRoundGrid(baseGrid)
  if #round == 0 then
    return
  end
  for _ = 1, self._boardConfig.RoundIslandCount do
    local r = self:GetBoardRandomNumber(1, #round)
    local grid = round[r]
    table.remove(round, r)
    local island = {}
    if self._maxIsland == nil then
      self._maxIsland = island
      island.length = self:GetBoardRandomNumber(self._boardConfig.LongIsland[2], self._boardConfig.LongIsland[3] + 1)
      grid.color = self._boardConfig.LongIsland[1]
    else
      island.length = self:GetBoardRandomNumber(2, self._maxIsland.length)
      grid.color = self:FillGridColorFromPool(grid)
    end
    self:AddGridColor(grid)
    table.insert(island, grid)
    table.insert(self._initIslands, island)
  end
end

function BoardServiceLogic:GrowIslandPool()
  for i, v in ipairs(self._initIslands) do
    self:GrowIsland(v)
  end
end

function BoardServiceLogic:GrowIsland(island)
  for i = 1, island.length do
    local color = island[1].color
    if self._colorPool[color] == 0 then
      return
    end
    local last = island[#island]
    local next = self:FindNextGrowGrid(last)
    if next == nil then
      return
    end
    self._colorPool[color] = self._colorPool[color] - 1
    next.color = color
    self:AddGridColor(next)
    table.insert(island, next)
  end
end

function BoardServiceLogic:IsMonsterConfigPos(pos)
  return false
end

local function Filter_FindNextGrowGrid(g, self, last)
  return g.color == PieceType.None and g ~= self._roleGrid and not self:IsMonsterConfigPos(last)
end

function BoardServiceLogic:FindNextGrowGrid(last)
  local round = self:GetRoundGrid(last, Filter_FindNextGrowGrid, self, last)
  if 0 < #round then
    local r = self:GetBoardRandomNumber(1, #round)
    return round[r]
  end
end

function BoardServiceLogic:FillRestGridColor()
  for _, grid in ipairs(self._gridArray) do
    if grid.color == PieceType.None and grid ~= self._roleGrid then
      grid.color = self:FillGridColorFromPool(grid)
      self:AddGridColor(grid)
    end
  end
end

local function Filter_FillGridColorFromPool(g, maxIsland)
  return table.icontains(maxIsland, g)
end

function BoardServiceLogic:FillGridColorFromPool(grid)
  local colors = {}
  for k, v in ipairs(self._colorPool) do
    if 0 < v then
      table.insert(colors, k)
    end
  end
  if 1 < #colors then
    local round = self:GetRoundGrid(grid, Filter_FillGridColorFromPool, self._maxIsland)
    if 0 < #round then
      table.removev(colors, self._maxIsland[1].color)
    end
  end
  if 0 < #colors then
    local r = self:GetBoardRandomNumber(1, #colors)
    local c = colors[r]
    self._colorPool[c] = self._colorPool[c] - 1
    return c
  end
  return self:GenGridColorByWeight()
end

function BoardServiceLogic:ExchangeGrid(gridA, gridB)
  local roundA = self:GetRoundGrid(gridA, Filter_MatchGAndGrid, gridA)
  for _, g in pairs(roundA) do
    g.connect = g.connect - gridA.connvalue
    self._totalConnect = self._totalConnect - g.connvalue - gridA.connvalue
  end
  local roundB = self:GetRoundGrid(gridB, Filter_MatchGAndGrid, gridB)
  for k, g in pairs(roundB) do
    g.connect = g.connect - gridB.connvalue
    self._totalConnect = self._totalConnect - g.connvalue - gridB.connvalue
  end
  local color = gridA.color
  gridA.color = gridB.color
  gridB.color = color
  roundA = self:GetRoundGrid(gridA, Filter_MatchGAndGrid, gridA)
  for k, g in pairs(roundA) do
    g.connect = g.connect + gridA.connvalue
    gridA.connect = gridA.connect + g.connvalue
    self._totalConnect = self._totalConnect + g.connvalue + gridA.connvalue
  end
  roundB = self:GetRoundGrid(gridB, Filter_MatchGAndGrid, gridB)
  for k, g in pairs(roundB) do
    g.connect = g.connect + gridB.connvalue
    gridB.connect = gridB.connect + g.connvalue
    self._totalConnect = self._totalConnect + g.connvalue + gridB.connvalue
  end
  self._connectRate = self._totalConnect / self._totalGridCnt
end

function BoardServiceLogic:AddGridColor(grid)
  if grid == self._roleGrid then
    return
  end
  local round = self:GetRoundGrid(grid, Filter_MatchGAndGrid, grid)
  for _, g in pairs(round) do
    g.connect = g.connect + grid.connvalue
    grid.connect = grid.connect + g.connvalue
    self._totalConnect = self._totalConnect + g.connvalue + grid.connvalue
  end
  self._totalGridCnt = self._totalGridCnt + 1
  self._connectRate = self._totalConnect / self._totalGridCnt
end

function BoardServiceLogic:RemoveGridColor(grid)
  if grid == self._roleGrid then
    return
  end
  local round = self:GetRoundGrid(grid, Filter_MatchGAndGrid, grid)
  for _, g in pairs(round) do
    g.connect = g.connect - grid.connvalue
    self._totalConnect = self._totalConnect - g.connvalue - grid.connvalue
  end
  grid.connect = 0
  grid.color = PieceType.None
  self._totalGridCnt = self._totalGridCnt - 1
  self._connectRate = self._totalConnect / self._totalGridCnt
end

local function Filter_AdjustConnectRate1(g, color)
  return g.color == color and g.connect < 3
end

local function Filter_AdjustConnectRate2(g, color, grid)
  return g.color ~= color and g.connect + grid.connect > 6
end

function BoardServiceLogic:AdjustConnectRate(target)
  if math.abs(target - self._connectRate) < 0.1 then
    return
  end
  if target > self._connectRate then
    for _, v in ipairs(self.GridTiles) do
      for _, grid in ipairs(v) do
        if self:IsValidPiecePos(grid) then
          local color = self:GetIncrGridColor(grid)
          if color ~= PieceType.None then
            local grid2 = self:FirstGrid(Filter_AdjustConnectRate1, color)
            if grid2 ~= nil then
              self:ExchangeGrid(grid, grid2)
              if math.abs(target - self._connectRate) < 0.1 then
                return
              end
            end
          end
        end
      end
    end
  else
    for _, v in ipairs(self.GridTiles) do
      for _, grid in ipairs(v) do
        local color = self:GetDecrGridColor(grid)
        if color ~= PieceType.None then
          local grid2 = self:FirstGrid(Filter_AdjustConnectRate2, color, grid)
          if grid2 ~= nil then
            self:ExchangeGrid(grid, grid2)
            if math.abs(target - self._connectRate) < 0.1 then
              return
            end
          end
        end
      end
    end
  end
end

function BoardServiceLogic:FirstGrid(filter, ...)
  if filter == nil then
    return
  end
  for _, v in ipairs(self.GridTiles) do
    for _, grid in ipairs(v) do
      if filter(grid, ...) then
        return grid
      end
    end
  end
end

function BoardServiceLogic:GetIncrGridColor(grid)
  if grid ~= self._roleGrid and grid.connect < 2 then
    local dict = self:CalcRoundGridColor(grid)
    for k, v in ipairs(dict) do
      if not CanMatchPieceType(k, grid.color) and 3 < v then
        return k
      end
    end
  end
  return PieceType.None
end

function BoardServiceLogic:GetDecrGridColor(grid)
  if grid.connect > 3 and grid.color ~= PieceType.Any then
    return grid.color
  end
  return PieceType.None
end

local function Filter_CalcRoundGridColor(g)
  return g.color ~= PieceType.None
end

function BoardServiceLogic:CalcRoundGridColor(grid)
  local dict = {
    [PieceType.Blue] = 0,
    [PieceType.Red] = 0,
    [PieceType.Green] = 0,
    [PieceType.Yellow] = 0,
    [PieceType.Any] = 0
  }
  local round = self:GetRoundGrid(grid, Filter_CalcRoundGridColor)
  for k, g in pairs(round) do
    dict[g.color] = dict[g.color] + 1
  end
  return dict
end

function BoardServiceLogic:SupplyPieceList(poslist)
  self._world:GetSyncLogger():Trace({
    key = "SupplyPieceList",
    posCnt = #poslist
  })
  local chainPath = {}
  for _, pos in ipairs(poslist) do
    local grid = self.GridTiles[pos.x][pos.y]
    if grid then
      table.insert(chainPath, grid)
      if self:GetCanConvertGridElement(grid) then
        self:RemoveGridColor(grid)
      end
    end
  end
  local round = self._world:BattleStat():GetPieceRefreshCount()
  if round == 0 then
    round = 1
  end
  if self._boardConfig.BoardMode == GenBoardMode.Guide and round <= #self._boardConfig.GuideBoard then
    local idx = self._boardConfig.GuideBoard[round]
    local cfg = Cfg.cfg_board_guide[idx]
    if cfg == nil then
      Log.error("GenBoardMode.Guide round=", round, " idx=", idx)
    end
    for _, grid in ipairs(chainPath) do
      if self:GetCanConvertGridElement(grid) then
        grid.color = cfg.Board[grid.x][grid.y]
        self:AddGridColor(grid)
      end
    end
    return chainPath
  end
  local useMaintainColorList = {}
  local colors = {}
  for _, grid in ipairs(chainPath) do
    if self:GetCanConvertGridElement(grid) then
      local maintainColor = self:_ApplyMaintainColor(grid)
      if maintainColor then
        grid.color = maintainColor
        table.insert(useMaintainColorList, grid)
      else
        grid.color = self:FillGridColorByWeight()
      end
      self:AddGridColor(grid)
      table.insert(colors, grid.color)
    end
  end
  colors.rate = self._connectRate
  for _, grid in ipairs(chainPath) do
    if self:GetCanConvertGridElement(grid) then
      self:RemoveGridColor(grid)
    end
  end
  local nResultIndex = 1
  for i, grid in ipairs(chainPath) do
    if self:GetCanConvertGridElement(grid) then
      grid.color = colors[nResultIndex]
      nResultIndex = nResultIndex + 1
      self:AddGridColor(grid)
    end
  end
  return chainPath, useMaintainColorList
end

function BoardServiceLogic:_ApplyMaintainColor(pos)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local posIndex = Vector2.Pos2Index(pos)
  local retColor = boardCmpt:GetMaintainColorForSupply(posIndex)
  if retColor then
    boardCmpt:ResetMaintainColorForSupply(posIndex)
    return retColor
  end
end

function BoardServiceLogic:SetMaintainColorForSupply(pos, maintainColor)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local posIndex = Vector2.Pos2Index(pos)
  boardCmpt:SetMaintainColorForSupply(posIndex, maintainColor)
end

function BoardServiceLogic:SyncGridTilesColor()
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  for x, col in ipairs(boardCmpt.Pieces) do
    for y, color in pairs(col) do
      local grid = self.GridTiles[x][y]
      if grid.color ~= color then
        self:RemoveGridColor(grid)
        grid.color = color
        self:AddGridColor(grid)
      end
    end
  end
end

function BoardServiceLogic:FallGrids(chainPath, dir, teamEntity)
  local delset = {}
  local newset = {}
  local movset = {}
  local rolegrid = {}
  local lastPos = chainPath[#chainPath]
  local boardLogicSvc = self._world:GetService("BoardLogic")
  boardLogicSvc:RemoveEntityBlockFlag(teamEntity, lastPos)
  if self:GetCanConvertGridElement(lastPos) then
    local maintainColor = self:_ApplyMaintainColor(lastPos)
    local lastGrid = self.GridTiles[lastPos.x][lastPos.y]
    lastGrid.color = PieceType.None
    rolegrid.color = PieceType.None
    rolegrid.pos = lastPos
  end
  boardLogicSvc:SetEntityBlockFlag(teamEntity, lastPos)
  for i = 1, #chainPath - 1 do
    local pos = chainPath[i]
    local grid = self.GridTiles[pos.x][pos.y]
    if grid then
      local maintainColor = self:_ApplyMaintainColor(pos)
      if maintainColor then
      else
        delset[#delset + 1] = {
          pos = pos,
          color = grid.color
        }
        grid.del = true
      end
    end
  end
  newset, movset = self:_FallGrid_CalSetByDir(dir)
  self:_FallGrid_DelGrids(delset)
  self:_FallGrid_DelMoveFromGrids(movset)
  self:_FallGrid_NewGrids(newset)
  self:_FallGrid_AddMoveToGrids(movset)
  return delset, newset, movset, rolegrid
end

function BoardServiceLogic:_FallGrid_CalSetByDir(dir)
  local newset = {}
  local movset = {}
  if dir.x == 0 and dir.y == -1 then
    newset, movset = self:_FallGrid_CalDown()
  elseif dir.x == 0 and dir.y == 1 then
    newset, movset = self:_FallGrid_CalUp()
  elseif dir.x == 1 and dir.y == 0 then
    newset, movset = self:_FallGrid_CalRight()
  elseif dir.x == -1 and dir.y == 0 then
    newset, movset = self:_FallGrid_CalLeft()
  end
  return newset, movset
end

function BoardServiceLogic:_FallGrid_CalDown()
  local slot
  local movset = {}
  local newset = {}
  local maxX = self:GetCurBoardMaxX()
  local maxY = self:GetCurBoardMaxY()
  
  local function findslot(x, y1)
    for y = y1, maxY do
      local grid = self.GridTiles[x][y]
      if grid and grid.del then
        slot = Vector2(x, y)
        return slot
      end
    end
  end
  
  local function findmove(x, y1)
    for y = y1, maxY do
      local grid = self.GridTiles[x][y]
      if grid then
        local pos = Vector2(x, y)
        if not grid.del and self:CanFallGrid(pos) then
          return pos
        end
      end
    end
  end
  
  for x = 1, maxX do
    slot = findslot(x, 1)
    while slot do
      local pos = findmove(x, slot.y + 1)
      if pos then
        local grid = self.GridTiles[pos.x][pos.y]
        grid.del = true
        movset[#movset + 1] = {
          from = pos,
          to = slot,
          color = grid.color
        }
      else
        local maxY = self:_GetMaxYOfColX(x)
        newset[#newset + 1] = {
          from = Vector2(x, maxY),
          pos = slot,
          color = self:FillGridColorByWeight()
        }
      end
      self.GridTiles[slot.x][slot.y].del = nil
      slot = findslot(x, slot.y + 1)
    end
  end
  return newset, movset
end

function BoardServiceLogic:_FallGrid_CalUp()
  local slot
  local movset = {}
  local newset = {}
  local maxX = self:GetCurBoardMaxX()
  local maxY = self:GetCurBoardMaxY()
  
  local function findslot(x, y1)
    for y = y1, 1, -1 do
      local grid = self.GridTiles[x][y]
      if grid and grid.del then
        slot = Vector2(x, y)
        return slot
      end
    end
  end
  
  local function findmove(x, y1)
    for y = y1, 1, -1 do
      local grid = self.GridTiles[x][y]
      if grid then
        local pos = Vector2(x, y)
        if not grid.del and self:CanFallGrid(pos) then
          return pos
        end
      end
    end
  end
  
  for x = 1, maxX do
    slot = findslot(x, maxY)
    while slot do
      local pos = findmove(x, slot.y - 1)
      if pos then
        local grid = self.GridTiles[pos.x][pos.y]
        grid.del = true
        movset[#movset + 1] = {
          from = pos,
          to = slot,
          color = grid.color
        }
      else
        local minY = self:_GetMinYOfColX(x)
        newset[#newset + 1] = {
          from = Vector2(x, minY),
          pos = slot,
          color = self:FillGridColorByWeight()
        }
      end
      self.GridTiles[slot.x][slot.y].del = nil
      slot = findslot(x, slot.y - 1)
    end
  end
  return newset, movset
end

function BoardServiceLogic:_FallGrid_CalLeft()
  local slot
  local movset = {}
  local newset = {}
  local maxX = self:GetCurBoardMaxX()
  local maxY = self:GetCurBoardMaxY()
  
  local function findslot(x1, y)
    for x = x1, maxX do
      local grid = self.GridTiles[x][y]
      if grid and grid.del then
        slot = Vector2(x, y)
        return slot
      end
    end
  end
  
  local function findmove(x1, y)
    for x = x1, maxX do
      local grid = self.GridTiles[x][y]
      if grid then
        local pos = Vector2(x, y)
        if not grid.del and self:CanFallGrid(pos) then
          return pos
        end
      end
    end
  end
  
  for y = 1, maxY do
    slot = findslot(1, y)
    while slot do
      local pos = findmove(slot.x + 1, slot.y)
      if pos then
        local grid = self.GridTiles[pos.x][pos.y]
        grid.del = true
        movset[#movset + 1] = {
          from = pos,
          to = slot,
          color = grid.color
        }
      else
        local maxX = self:_GetMaxXOfRowY(y)
        newset[#newset + 1] = {
          from = Vector2(maxX, y),
          pos = slot,
          color = self:FillGridColorByWeight()
        }
      end
      self.GridTiles[slot.x][slot.y].del = nil
      slot = findslot(slot.x + 1, slot.y)
    end
  end
  return newset, movset
end

function BoardServiceLogic:_FallGrid_CalRight()
  local slot
  local movset = {}
  local newset = {}
  local maxX = self:GetCurBoardMaxX()
  local maxY = self:GetCurBoardMaxY()
  
  local function findslot(x1, y)
    for x = x1, 1, -1 do
      local grid = self.GridTiles[x][y]
      if grid and grid.del then
        slot = Vector2(x, y)
        return slot
      end
    end
  end
  
  local function findmove(x1, y)
    for x = x1, 1, -1 do
      local grid = self.GridTiles[x][y]
      if grid then
        local pos = Vector2(x, y)
        if not grid.del and self:CanFallGrid(pos) then
          return pos
        end
      end
    end
  end
  
  for y = 1, maxY do
    slot = findslot(maxX, y)
    while slot do
      local pos = findmove(slot.x - 1, slot.y)
      if pos then
        local grid = self.GridTiles[pos.x][pos.y]
        grid.del = true
        movset[#movset + 1] = {
          from = pos,
          to = slot,
          color = grid.color
        }
      else
        local minX = self:_GetMinXOfRowY(y)
        newset[#newset + 1] = {
          from = Vector2(minX, y),
          pos = slot,
          color = self:FillGridColorByWeight()
        }
      end
      self.GridTiles[slot.x][slot.y].del = nil
      slot = findslot(slot.x - 1, slot.y)
    end
  end
  return newset, movset
end

function BoardServiceLogic:_FallGrid_DelGrids(delset)
  for _, v in ipairs(delset) do
    local grid = self.GridTiles[v.pos.x][v.pos.y]
    self:RemoveGridColor(grid)
  end
end

function BoardServiceLogic:_FallGrid_NewGrids(newset)
  for _, v in ipairs(newset) do
    local grid = self.GridTiles[v.pos.x][v.pos.y]
    grid.color = v.color
    self:AddGridColor(grid)
  end
end

function BoardServiceLogic:_FallGrid_DelMoveFromGrids(movset)
  for _, v in ipairs(movset) do
    local grid = self.GridTiles[v.from.x][v.from.y]
    self:RemoveGridColor(grid)
  end
end

function BoardServiceLogic:_FallGrid_AddMoveToGrids(movset)
  for _, v in ipairs(movset) do
    local grid = self.GridTiles[v.to.x][v.to.y]
    grid.color = v.color
    self:AddGridColor(grid)
  end
end

function BoardServiceLogic:_GetMinXOfRowY(rowY)
  local maxX = self:GetCurBoardMaxX()
  local retX = 1
  for index = 1, maxX do
    local colTiles = self.GridTiles[index]
    if colTiles then
      local tile = colTiles[rowY]
      if tile then
        retX = index
        break
      end
    end
  end
  return retX
end

function BoardServiceLogic:_GetMaxXOfRowY(rowY)
  local maxX = self:GetCurBoardMaxX()
  local retX = maxX
  for index = maxX, 1, -1 do
    local colTiles = self.GridTiles[index]
    if colTiles then
      local tile = colTiles[rowY]
      if tile then
        retX = index
        break
      end
    end
  end
  return retX
end

function BoardServiceLogic:_GetMinYOfColX(colX)
  local maxY = self:GetCurBoardMaxY()
  local retY = 1
  local colTiles = self.GridTiles[colX]
  if colTiles then
    for index = 1, maxY do
      local tile = colTiles[index]
      if tile then
        retY = index
        break
      end
    end
  end
  return retY
end

function BoardServiceLogic:_GetMaxYOfColX(colX)
  local maxY = self:GetCurBoardMaxY()
  local retY = maxY
  local colTiles = self.GridTiles[colX]
  if colTiles then
    for index = maxY, 1, -1 do
      local tile = colTiles[index]
      if tile then
        retY = index
        break
      end
    end
  end
  return retY
end

function BoardServiceLogic:GetMinXOfRowY(rowY)
  return self:_GetMinXOfRowY(rowY)
end

function BoardServiceLogic:GetMaxXOfRowY(rowY)
  return self:_GetMaxXOfRowY(rowY)
end

function BoardServiceLogic:GetMinYOfColX(colX)
  return self:_GetMinYOfColX(colX)
end

function BoardServiceLogic:GetMaxYOfColX(colX)
  return self:_GetMaxYOfColX(colX)
end

function BoardServiceLogic:CalculateSupplyPieceWeights(boardSupplyPieceWeights)
  local levelConfigData = self._configService:GetLevelConfigData()
  if levelConfigData:IsApplyPetSupplyPieceWeight() and self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    local baseBoardSupplyPieceWeights = table.cloneconf(boardSupplyPieceWeights)
    local listMatchPet = self._world:GetLocalMatchPetList()
    for _, matchPet in ipairs(listMatchPet) do
      local petWeights = matchPet:GetPetSupplyPieceWeights()
      if petWeights then
        if #petWeights ~= 5 then
          Log.error("Cfg PetSupplyPieceWeights size error: pet ID:", matchPet:GetTemplateID())
        end
        for index, value in ipairs(petWeights) do
          if baseBoardSupplyPieceWeights[index] ~= 0 then
            boardSupplyPieceWeights[index] = boardSupplyPieceWeights[index] + value
          end
        end
      end
    end
    local enlightenInfo = self:_CalcEnlightenActiveType()
    if enlightenInfo then
      local baseWeights = table.cloneconf(boardSupplyPieceWeights)
      local enlightenWeights = enlightenInfo:GetSupplyPieceWeights()
      if enlightenWeights then
        if #enlightenWeights ~= 5 then
          Log.error("Cfg SupplyPieceWeight enlighten weights error!!!")
        end
        for index, value in ipairs(enlightenWeights) do
          if baseWeights[index] ~= 0 then
            boardSupplyPieceWeights[index] = boardSupplyPieceWeights[index] + value
          end
        end
      end
    end
  end
  local totalSupplyWeight = 0
  for i = 1, #boardSupplyPieceWeights do
    if boardSupplyPieceWeights[i] < 0 then
      boardSupplyPieceWeights[i] = 0
    end
    totalSupplyWeight = totalSupplyWeight + boardSupplyPieceWeights[i]
  end
  if totalSupplyWeight < 1 then
    Log.error("Cfg SupplyPieceWeight total weight error!!!")
  end
  self._supplyPieceTotalWeight = MultModifyValue_Add:New(totalSupplyWeight)
  Log.info("total supply weight = :", totalSupplyWeight)
  self._supplyPieceWeights = {
    [PieceType.Blue] = MultModifyValue_Add:New(boardSupplyPieceWeights[1]),
    [PieceType.Red] = MultModifyValue_Add:New(boardSupplyPieceWeights[2]),
    [PieceType.Green] = MultModifyValue_Add:New(boardSupplyPieceWeights[3]),
    [PieceType.Yellow] = MultModifyValue_Add:New(boardSupplyPieceWeights[4]),
    [PieceType.Any] = MultModifyValue_Add:New(boardSupplyPieceWeights[5])
  }
end

function BoardServiceLogic:_CalcEnlightenActiveType()
  local elementTypeDic = {}
  local listMatchPet = self._world:GetLocalMatchPetList()
  for _, matchPet in ipairs(listMatchPet) do
    local primaryType = matchPet:GetPetFirstElement()
    if not elementTypeDic[primaryType] then
      elementTypeDic[primaryType] = {}
    end
    table.insert(elementTypeDic[primaryType], matchPet)
  end
  for type, petList in pairs(elementTypeDic) do
    if table.count(petList) >= BattleConst.ActiveEnlightenPetMinNum then
      return self._world:GetEnlightenInfoByType(type)
    end
  end
end

function BoardServiceLogic:GenerateSpliceBoard(boardId)
  local boardEntity = self._world:GetBoardEntity()
  local spliceBoardPosList = self:GetSpliceBoardPosList()
  local spliceGridTiles = {}
  if spliceBoardPosList then
    for i = 1, #spliceBoardPosList do
      local x = spliceBoardPosList[i][1]
      local y = spliceBoardPosList[i][2]
      local color = spliceBoardPosList[i][3] or PieceType.None
      if color == -1 then
        color = self:FillGridColorByWeight()
      end
      if not spliceGridTiles[x] then
        spliceGridTiles[x] = {}
      end
      spliceGridTiles[x][y] = {
        x = x,
        y = y,
        connect = 0,
        color = color,
        connvalue = 0
      }
    end
  end
  return spliceGridTiles
end

function BoardServiceLogic:PopStarGridByFallDir(posList, dir)
  local delSet = {}
  local newSet = {}
  local moveSet = {}
  for i = 1, #posList do
    local pos = posList[i]
    local grid = self.GridTiles[pos.x][pos.y]
    if grid then
      delSet[#delSet + 1] = {
        pos = pos,
        color = grid.color
      }
      grid.del = true
    end
  end
  newSet, moveSet = self:_FallGrid_CalSetByDir(dir)
  self:_FallGrid_DelGrids(delSet)
  self:_FallGrid_DelMoveFromGrids(moveSet)
  self:_FallGrid_NewGrids(newSet)
  self:_FallGrid_AddMoveToGrids(moveSet)
  return delSet, newSet, moveSet
end

function BoardServiceLogic:GetCurBoardGeneratePieceAmount()
  local affixSvc = self._world:GetService("Affix")
  local generatePieceAmount = affixSvc:ProcessGeneratePieceAmount(self._boardConfig.GeneratePieceAmount)
  return generatePieceAmount
end

function BoardServiceLogic:GetCurBoardGeneratePieceWeight()
  local affixSvc = self._world:GetService("Affix")
  local generatePieceWeight = affixSvc:ProcessGeneratePieceWeight(self._boardConfig.GeneratePieceWeight)
  return generatePieceWeight
end

function BoardServiceLogic:ProcessSupplyPieceWeight(baseSupplyPieceWeight)
  local affixSvc = self._world:GetService("Affix")
  local generatePieceWeight = affixSvc:ProcessSupplyPieceWeight(baseSupplyPieceWeight)
  return generatePieceWeight
end

function BoardServiceLogic:GeneratePushBoard(pushBoardPosList)
  local pushGridTiles = {}
  if pushBoardPosList then
    for i = 1, #pushBoardPosList do
      local x = pushBoardPosList[i][1]
      local y = pushBoardPosList[i][2]
      local color = pushBoardPosList[i][3] or PieceType.None
      if color == -1 then
        color = self:FillGridColorByWeight()
      end
      if not pushGridTiles[x] then
        pushGridTiles[x] = {}
      end
      pushGridTiles[x][y] = {
        x = x,
        y = y,
        connect = 0,
        color = color,
        connvalue = 0
      }
    end
  end
  return pushGridTiles
end
