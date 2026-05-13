local unitDataSet = require("csvdata.unit")
local blockDataSet = require("csvdata.block_c")
local specialBlockDataSet = require("csvdata.block_s")
local MaxBlockNum = 8
local BlockInterval = 1.5
local ATTR_SPEED_UP = 1.2
local DetectIntervals = {
  [0] = 4.5,
  [1] = 4.5,
  [2] = 4.5,
  [3] = 4.5,
  [4] = 3,
  [5] = 3,
  [6] = 1.5,
  [7] = 1.5,
  [8] = 1.5,
  [9] = 0.5
}

local function parseBlockId(blockIdStr)
  local data = string.split(blockIdStr, "_")
  return data[1] == "left" and SIDE_LEFT or SIDE_RIGHT, tonumber(data[2]), tonumber(data[3])
end

local BlockGroup = class("BlockGroup")

function BlockGroup:ctor(params)
  self.blockIdStr = params.blockIdStr or ""
  self.player = params.player
  self.number = 0
  local _, index, blockId = parseBlockId(self.blockIdStr)
  self.playerIndex = index
  self.blockId = blockId
end

function BlockGroup:insertNewBlock()
  self.number = self.number + 1
end

function BlockGroup:removeBlock(number)
  if number > self.number then
    number = self.number
  end
  self.number = self.number - number
  return number
end

function BlockGroup:releaseSkill()
  if not self.player or self.player:getState() == "Dead" then
    return
  end
  self.player:dispatchEvent({
    name = "releaseBlockSkill",
    blockId = self.blockId,
    number = self.number
  })
end

local AutoBlockClear = class("AutoBlockClear")

function AutoBlockClear:ctor(params)
  params = params or {}
  params.attrItems = params.attrItems or {}
  self.groups = {}
  self.side = params.side or SIDE_RIGHT
  self.battle = params.battle
  self.detectInterval = DetectIntervals[0]
  self.leaderBonus = params.attrItems[1]
  self.speedUp = params.attrItems[2]
  self.interval = self.speedUp and BlockInterval / ATTR_SPEED_UP or BlockInterval
  self.beauty = self.battle:getCamp(self.side):getSelfBeauty()
  self.blockIds = {}
  self:initBlockIds()
end

function AutoBlockClear:initBlockIds()
  for _, player in ipairs(self.battle:getPlayers(self.side)) do
    local unitData = unitDataSet[player.type]
    self.blockIds[player:getOrigKey() .. "_" .. unitData.blockId] = {
      weight = player.leader and 44 or 28
    }
    self.blockIds[player:getOrigKey() .. "_" .. unitData.specialBlock] = {weight = 0}
    player:addEventListener("newBlock", function(event)
      for index = 1, event.number do
        self:moveBlock(player:getOrigKey() .. "_" .. event.blockId)
      end
    end)
    player:addEventListener("playerDead", function(event)
      if not player.leader then
        return
      end
      self.blockIds[player:getOrigKey() .. "_" .. unitData.blockId].weight = 25
      local otherBlockIds = {}
      for blockIdStr, data in pairs(self.blockIds) do
        local side, playerIndex, blockId = parseBlockId(blockIdStr)
        local other = self.battle:getPlayerByIndex(side, playerIndex)
        if other and blockId ~= unitData.blockId and data.weight > 0 then
          table.insert(otherBlockIds, blockIdStr)
        end
      end
      if 0 < #otherBlockIds then
        local index = math.randomInt(1, #otherBlockIds)
        self.blockIds[otherBlockIds[index]].weight = 50
        local side, playerIndex, blockId = parseBlockId(otherBlockIds[index])
        local newLeader = self.battle:getPlayerByIndex(side, playerIndex)
        newLeader.leader = true
        newLeader:dispatchEvent({name = "newLeader"})
      end
    end)
  end
end

function AutoBlockClear:randomBlock()
  return math.randWeight(self.blockIds)
end

function AutoBlockClear:initFiveBlock()
  local randomIds = {}
  for count = 1, 5 do
    local blockId = self:randomBlock()
    table.insert(randomIds, blockId)
  end
  if self.leaderBonus then
    for blockId, data in pairs(self.blockIds) do
      if data.weight == 44 then
        table.insert(randomIds, blockId)
        table.insert(randomIds, blockId)
        break
      end
    end
  end
  for _, blockId in ipairs(randomIds) do
    self:moveBlock(blockId)
  end
end

function AutoBlockClear:getTotalBlockCnt()
  local totalBlockCnt = 0
  for _, group in ipairs(self.groups) do
    totalBlockCnt = totalBlockCnt + group.number
  end
  return totalBlockCnt
end

function AutoBlockClear:moveBlock(blockIdStr)
  local playerSide, playerIndex, blockId = parseBlockId(blockIdStr)
  local player = self.battle:getPlayerByIndex(playerSide, playerIndex)
  if player and player:getState() == "Dead" then
    player = nil
  end
  local totalBlockCnt = self:getTotalBlockCnt()
  if totalBlockCnt >= MaxBlockNum then
    return
  end
  if #self.groups == 0 then
    local firstGroup = BlockGroup:create({blockIdStr = blockIdStr, player = player})
    firstGroup:insertNewBlock()
    table.insert(self.groups, firstGroup)
  else
    local lastGroup = self.groups[#self.groups]
    if lastGroup.blockId > 10000 or lastGroup.blockIdStr ~= blockIdStr or lastGroup.number == 3 then
      local totalBlockCnt = self:getTotalBlockCnt()
      local newGroup = BlockGroup:create({blockIdStr = blockIdStr, player = player})
      newGroup:insertNewBlock()
      table.insert(self.groups, newGroup)
    else
      lastGroup:insertNewBlock()
    end
  end
end

function AutoBlockClear:rearrangeBlocks(groupIndex)
  if groupIndex == #self.groups or self.groups[groupIndex].blockId > 10000 or self.groups[groupIndex].blockIdStr ~= self.groups[groupIndex + 1].blockIdStr or self.groups[groupIndex].number == 3 then
    return
  end
  local preNumber = self.groups[groupIndex].number
  local movedNum = self.groups[groupIndex + 1]:removeBlock(3 - preNumber)
  for index = 1, movedNum do
    self.groups[groupIndex]:insertNewBlock()
  end
  if self.groups[groupIndex + 1].number == 0 then
    table.remove(self.groups, groupIndex + 1)
  else
    self:rearrangeBlocks(groupIndex + 1)
  end
end

function AutoBlockClear:removeGroup(groupIndex)
  local group = self.groups[groupIndex]
  if DEBUG > 0 then
    printInfo(string.format("[%d] removeGroup-%d: %s", os.time(), groupIndex, group.blockIdStr))
  end
  local cellNum = group.number
  if group.blockId < 10000 and self.beauty then
    self.beauty:addAngryValue({number = cellNum})
  end
  table.remove(self.groups, groupIndex)
  group:releaseSkill()
  if not self.groups[groupIndex] then
    return
  end
  if 1 < groupIndex then
    self:rearrangeBlocks(groupIndex - 1)
  end
end

function AutoBlockClear:dump()
  if DEBUG == 0 then
    return
  end
  for index, group in ipairs(self.groups) do
    printInfo(string.format("group-%d: %s, %d", index, group.blockIdStr, group.number))
  end
end

function AutoBlockClear:chooseGroup()
  local deadPlayer = false
  local maxWeight = -math.huge
  local maxIndex
  for index, group in ipairs(self.groups) do
    if group.blockId > 10000 then
      maxIndex = index
      break
    end
    if not group.player then
      maxIndex = index
      deadPlayer = true
      break
    end
    local weight = group.number > 3 and 100 or group.number
    local leftGroup = self.groups[index + 1]
    local rightGroup = self.groups[index - 1]
    if leftGroup and rightGroup and leftGroup.blockIdStr == rightGroup.blockIdStr and leftGroup.number < 3 and rightGroup.number < 3 then
      weight = leftGroup.number + rightGroup.number
    end
    if maxWeight < weight then
      maxWeight = weight
      maxIndex = index
    end
  end
  self:dump()
  assert(maxIndex, "must be exist a group to release")
  self:removeGroup(maxIndex)
  return deadPlayer
end

function AutoBlockClear:update(dt)
  self.detectInterval = self.detectInterval - dt
  if self.detectInterval <= 0 then
    local hasDeadPlayer = self:chooseGroup()
    local totalBlockCnt = self:getTotalBlockCnt()
    if hasDeadPlayer and 0 < totalBlockCnt then
      self.detectInterval = DetectIntervals[9]
    else
      self.detectInterval = DetectIntervals[totalBlockCnt]
    end
  end
  local totalBlockCnt = self:getTotalBlockCnt()
  if totalBlockCnt >= MaxBlockNum then
    return
  end
  self.interval = self.interval - 1
  if 0 >= self.interval then
    self.interval = self.speedUp and BlockInterval / ATTR_SPEED_UP or BlockInterval
    self:moveBlock(self:randomBlock())
  end
end

return AutoBlockClear
