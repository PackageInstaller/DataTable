local this = class("dungeonPlayManager")
local PATH = "Program/Dungeon/RandomDungeon"
local bossRoom = "BossRoom"
local blockSize = 50
local rowCount = 4
local DirectionType = {
  Left = 1,
  Right = 4,
  Down = 2,
  Up = 8
}

function this:ctor()
  self.blockInfos = nil
  self.connectDirectionMap = nil
end

function this:loadRandomScene(randomDungeonId, position, isDynamic, callback)
  self.blockInfos = {}
  randomDungeonId = randomDungeonId or AzurWorldInstance.CurWorldId
  local dungeonRandomTpl = L_GameTpl:getDungeonRandomTpl()
  local tpl = dungeonRandomTpl:getTplById(randomDungeonId)
  local pathGroup = dungeonRandomTpl:getPathGroup(tpl)
  local pathPrefab = dungeonRandomTpl:getPathPrefab(tpl)
  local pathPrefabIndex = 1
  self.root = L_CommonUtil.getGameObject("RandomDungeonNode", true)
  L_Vector3.setRelativePos(self.root.transform, L_Vector3.zero)
  self.root.transform.position = L_Vector3.zero
  local roadEnd = dungeonRandomTpl:getRoadEnd(tpl)
  local bossRoomDir = dungeonRandomTpl:getBossRoomDir(tpl)
  self:initConnectionMap(pathGroup, roadEnd, bossRoomDir)
  for i, v in ipairs(pathGroup) do
    local index = i - 1
    local path
    if not math.isEmpty(v) then
      path = string.format("%s/%s.prefab", PATH, pathPrefab[pathPrefabIndex])
      pathPrefabIndex = pathPrefabIndex + 1
    end
    local posX = index % rowCount
    local posY = math.floor(index / rowCount)
    local blockInfo = require(L_R.world.dungeon .. "dungeonBlockInfo").new()
    blockInfo.name = index
    blockInfo.prefabPath = path
    blockInfo.pos = L_Vector3.new(blockSize / 2 + blockSize * posX, 0, blockSize * (rowCount - 0.5) - blockSize * posY)
    blockInfo.rot = self:getRotateEulerAngle(v)
    blockInfo.blockSize = blockSize
    blockInfo.root = self.root
    blockInfo.showBlockList = self:getCanViewBlockList(pathGroup, index)
    if not isDynamic then
      blockInfo:setActive(true, true)
    end
    self.blockInfos[index] = blockInfo
  end
  local bossRoomPrefab = dungeonRandomTpl:getBossRoomPrefab(tpl)
  if not math.isEmpty(bossRoomDir) then
    local index = bossRoom
    local path = string.format("%s/%s.prefab", PATH, bossRoomPrefab)
    local posX = roadEnd % rowCount
    local posY = math.floor(roadEnd / rowCount)
    local dif = self:getBossRoomPosDif(bossRoomDir)
    local blockInfo = require(L_R.world.dungeon .. "dungeonBlockInfo").new()
    blockInfo.name = index
    blockInfo.prefabPath = path
    blockInfo.pos = L_Vector3.new(blockSize / 2 + blockSize * posX + dif.x, 0, blockSize * (rowCount - 0.5) - blockSize * posY + dif.z)
    blockInfo.rot = self:getBossRoomRotateEulerAngle(bossRoomDir)
    blockInfo.blockSize = blockSize * 2
    blockInfo.root = self.root
    blockInfo.showBlockList = self:getCanViewBlockListBossRoom(pathGroup, roadEnd, bossRoomDir)
    if not isDynamic then
      blockInfo:setActive(true, true)
    end
    self.blockInfos[index] = blockInfo
  end
  if isDynamic then
    self:refreshBlockByPos(position, true)
  end
  if callback then
    callback()
  end
end

function this:initConnectionMap(pathGroup, roadEnd, bossRoomDir)
  self.connectDirectionMap = {}
  self.connectDirectionMap[DirectionType.Down] = {}
  self.connectDirectionMap[DirectionType.Up] = {}
  self.connectDirectionMap[DirectionType.Left] = {}
  self.connectDirectionMap[DirectionType.Right] = {}
  local minIndex = 0
  local maxIndex = rowCount * rowCount - 1
  for i, v in ipairs(pathGroup) do
    if not math.isEmpty(v) then
      local index = i - 1
      local x = index % rowCount
      if v & DirectionType.Down ~= 0 and maxIndex >= index + rowCount then
        self.connectDirectionMap[DirectionType.Down][index] = index + rowCount
        self.connectDirectionMap[DirectionType.Up][index + rowCount] = index
      end
      if v & DirectionType.Up ~= 0 and minIndex <= index - rowCount then
        self.connectDirectionMap[DirectionType.Up][index] = index - rowCount
        self.connectDirectionMap[DirectionType.Down][index - rowCount] = index
      end
      if v & DirectionType.Left ~= 0 and 0 <= x - 1 then
        self.connectDirectionMap[DirectionType.Left][index] = index - 1
        self.connectDirectionMap[DirectionType.Right][index - 1] = index
      end
      if v & DirectionType.Right ~= 0 and x + 1 < rowCount then
        self.connectDirectionMap[DirectionType.Right][index] = index + 1
        self.connectDirectionMap[DirectionType.Left][index + 1] = index
      end
    end
  end
  if bossRoomDir and roadEnd then
    self.connectDirectionMap[bossRoomDir][roadEnd] = bossRoom
    self.connectDirectionMap[self:getOppositeDirection(bossRoomDir)][bossRoom] = roadEnd
  end
end

function this:getOppositeDirection(direction)
  if direction == DirectionType.Left then
    return DirectionType.Right
  elseif direction == DirectionType.Right then
    return DirectionType.Left
  elseif direction == DirectionType.Up then
    return DirectionType.Down
  elseif direction == DirectionType.Down then
    return DirectionType.Up
  end
end

function this:getCanViewBlockListBossRoom(pathGroup, roadEnd, bossRoomDir)
  local list = {}
  list[bossRoom] = true
  list[roadEnd] = true
  local oppositeDirection = self:getOppositeDirection(bossRoomDir)
  local ret = self:getCanViewBlockList(pathGroup, roadEnd, oppositeDirection)
  for i, v in pairs(ret) do
    list[i] = true
  end
  return list
end

function this:getCanViewBlockList(pathGroup, index, specialDirection)
  if specialDirection == nil then
    specialDirection = 15
  end
  local list = {}
  list[index] = true
  local v = pathGroup[index + 1]
  if math.isEmpty(v) then
    return list
  end
  local minIndex = 0
  local maxIndex = rowCount * rowCount - 1
  local directionMap = self.connectDirectionMap[DirectionType.Down]
  if directionMap[index] and specialDirection & DirectionType.Down ~= 0 then
    local tmpIndex = index
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
    while maxIndex >= tmpIndex + rowCount do
      if directionMap[tmpIndex] then
        tmpIndex = tmpIndex + rowCount
        list[tmpIndex] = true
      else
        break
      end
    end
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
  end
  directionMap = self.connectDirectionMap[DirectionType.Up]
  if directionMap[index] and specialDirection & DirectionType.Up ~= 0 then
    local tmpIndex = index
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
    while 0 <= tmpIndex - rowCount do
      if directionMap[tmpIndex] then
        tmpIndex = tmpIndex - rowCount
        list[tmpIndex] = true
      else
        break
      end
    end
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
  end
  directionMap = self.connectDirectionMap[DirectionType.Left]
  if directionMap[index] and specialDirection & DirectionType.Left ~= 0 then
    local tmpIndex = index
    local x = tmpIndex % rowCount
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
    while x - 1 >= 0 do
      if directionMap[tmpIndex] then
        tmpIndex = tmpIndex - 1
        x = x - 1
        list[tmpIndex] = true
      else
        break
      end
    end
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
  end
  directionMap = self.connectDirectionMap[DirectionType.Right]
  if directionMap[index] and specialDirection & DirectionType.Right ~= 0 then
    local tmpIndex = index
    local x = tmpIndex % rowCount
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
    while x + 1 < rowCount do
      if directionMap[tmpIndex] then
        tmpIndex = tmpIndex + 1
        x = x + 1
        list[tmpIndex] = true
      else
        break
      end
    end
    if directionMap[tmpIndex] == bossRoom then
      list[bossRoom] = true
    end
  end
  return list
end

function this:unLoadRandomScene()
  if not self.root then
    return
  end
  if self.blockInfos then
    for _, v in pairs(self.blockInfos) do
      v:dispose()
    end
  end
  self.blockInfos = nil
  Unity.GameObject.DestroyImmediate(self.root)
  self.root = nil
  self.connectMap = nil
end

function this:getRotateEulerAngle(road)
  if road == 2 or road == 6 or road == 14 or road == 10 then
    return L_Vector3.new(0, -90, 0)
  elseif road == 4 or road == 12 or road == 13 then
    return L_Vector3.new(0, 180, 0)
  elseif road == 8 or road == 9 or road == 11 then
    return L_Vector3.new(0, 90, 0)
  end
  return L_Vector3.zero
end

function this:getBossRoomPosDif(bossRoomDir)
  local dif = blockSize * 1.5
  if bossRoomDir == 1 then
    return L_Vector3.new(-dif, 0, 0)
  elseif bossRoomDir == 2 then
    return L_Vector3.new(0, 0, -dif)
  elseif bossRoomDir == 4 then
    return L_Vector3.new(dif, 0, 0)
  elseif bossRoomDir == 8 then
    return L_Vector3.new(0, 0, dif)
  end
  return L_Vector3.zero
end

function this:getBossRoomRotateEulerAngle(bossRoomDir)
  if bossRoomDir == 1 then
    return L_Vector3.new(0, 180, 0)
  elseif bossRoomDir == 2 then
    return L_Vector3.new(0, 90, 0)
  elseif bossRoomDir == 4 then
    return L_Vector3.new(0, 0, 0)
  elseif bossRoomDir == 8 then
    return L_Vector3.new(0, -90, 0)
  end
  return L_Vector3.zero
end

function this:refreshBlockByPos(position, isSync)
  if self.blockInfos == nil then
    return
  end
  local blockInfo = self:getCurBlockInfo(position)
  if blockInfo == nil then
    return
  end
  local showBlockList = blockInfo.showBlockList
  if showBlockList == nil then
    return
  end
  for _, v in pairs(self.blockInfos) do
    v:setActive(showBlockList[v.name] == true, isSync)
  end
end

function this:getCurBlockInfo(position)
  local bossRoomBlockInfo = self.blockInfos[bossRoom]
  if bossRoomBlockInfo and bossRoomBlockInfo:judgeInCurBlcok(position) then
    return bossRoomBlockInfo
  end
  local xIndex = math.clamp(math.floor(position.x / blockSize), 0, rowCount - 1)
  local yIndex = rowCount - 1 - math.clamp(math.floor(position.z / blockSize), 0, rowCount - 1)
  local index = xIndex + yIndex * rowCount
  return self.blockInfos[index]
end

return this
