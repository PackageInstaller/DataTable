local socket = require("socket")
local Entity = import(".Entity")
local Camp = import(".Camp")
local ActionManager = import(".ActionManager")

local function otherSide(side)
  return side == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT
end

local Battle = class("Battle", Entity)

function Battle:ctor(params)
  Battle.super.ctor(self, params)
  params = params or {}
  self.frameTick = 0
  self.startTime = socket.gettime()
  self.passTime = 0
  self.phasePassTime = 0
  self.selfFrameEvents = {}
  self.syncFrameEvents = {}
  self.battleSeed = params.seed
  self.battleType = params.battleType
  self.modeType = params.modeType
  self.totalPhase = params.totalPhase or 1
  self.battleStatus = 0
  self.arrangeRowTime = 0.4
  self.taste = 0
  self.tastePlayers = {}
  self.camps = {
    [SIDE_LEFT] = Camp:create({side = SIDE_LEFT, battle = self}),
    [SIDE_RIGHT] = Camp:create({side = SIDE_RIGHT, battle = self})
  }
  self.indexs = {
    [SIDE_LEFT] = 1,
    [SIDE_RIGHT] = 1
  }
  self.players = {
    [SIDE_LEFT] = {},
    [SIDE_RIGHT] = {}
  }
  self.origPlayers = {
    [SIDE_LEFT] = {},
    [SIDE_RIGHT] = {}
  }
  self.actionManager = ActionManager.new()
  math.randomSeed(self.battleSeed)
end

function Battle:reset(params)
  params = params or {}
  self.currentPhase = params.currentPhase or 1
  self.spaceTime = params.spaceTime or 0
  self.phasePassTime = 0
  local leftPlayers = self:getPlayers(SIDE_LEFT)
  local rightPlayers = self:getPlayers(SIDE_RIGHT)
  for _, player in ipairs(leftPlayers) do
    player:onPhaseBegin()
  end
  for _, player in ipairs(rightPlayers) do
    player:onPhaseBegin()
  end
end

function Battle:addPlayer(player)
  table.insert(self:getPlayers(player.side), player)
  table.insert(self.origPlayers[player.side], player)
  player:addToBattle(self)
  player:doEvent("idle")
  if self.battleStatus ~= 2 then
    self.battleStatus = player.side == SIDE_LEFT and 1 or 2
  end
  if player.side == SIDE_LEFT then
    self.orginCount = #self.players[SIDE_LEFT]
  end
end

function Battle:nextPlayerIdx(side)
  local current = self.indexs[side]
  self.indexs[side] = self.indexs[side] + 1
  return current
end

function Battle:addCalleePlayer(player)
  if self:gameOver() then
    return
  end
  table.insert(self:getPlayers(player.side), player)
  table.insert(self.origPlayers[player.side], player)
  player:addToBattle(self)
  player:doEvent("idle")
  self:dispatchEvent({
    name = "addCalleePlayer",
    player = player
  })
end

function Battle:addBeauty(beauty)
  self.camps[beauty.side]:addBeauty(beauty)
  beauty:doEvent("nothing")
end

function Battle:addPet(pet)
  self.camps[pet.side]:addPet(pet)
  pet:doEvent("nothing")
end

function Battle:removePlayer(player)
  local players = self:getPlayers(player.side)
  if table.nums(players) == 1 and player.side ~= SIDE_LEFT then
    self:dispatchEvent({
      name = "teamOver",
      side = player.side
    })
  end
  table.removebyvalue(players, player)
end

function Battle:getPlayerByIndex(side, index)
  for _, player in ipairs(self.origPlayers[side]) do
    if player.index == index then
      return player
    end
  end
  return nil
end

function Battle:addSkill(skill)
  local camp = self.camps[skill.side]
  skill.battle = self
  camp:addSkill(skill)
end

function Battle:getCamp(side)
  return self.camps[side]
end

function Battle:getPlayers(side)
  return self.players[side]
end

function Battle:getTeamers(player)
  local teamers = {}
  for _, teamer in pairs(self:getPlayers(player.side)) do
    if player ~= teamer then
      table.insert(teamers, teamer)
    end
  end
  return teamers
end

function Battle:getTeamLeader(player)
  for _, teamer in pairs(self:getPlayers(player.side)) do
    if teamer.leader then
      return teamer
    end
  end
  return player
end

function Battle:frontestTeamer(side)
  return self:getPlayers(side)[1]
end

function Battle:getEnemys(player)
  return self:getPlayers(otherSide(player.side))
end

function Battle:backmostTeamer(side)
  return self:getPlayers(side)[#self:getPlayers(side)]
end

function Battle:backmostEnemy(side)
  self:backmostTeamer(side == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT)
end

function Battle:nearestEnemy(player)
  local allEnemys = self:getPlayers(player.otherSide)
  local minEnemy
  local minDistance = math.huge
  for _, enemy in ipairs(allEnemys) do
    local distance = self:distance(player, enemy)
    if minDistance > distance then
      minEnemy = enemy
      minDistance = distance
    end
  end
  return minEnemy
end

function Battle:rangeTeamers(player, distance)
  local allTeamers = self:getPlayers(player.side)
  local result = {}
  for _, teamer in ipairs(allTeamers) do
    if distance >= self:distance(player, teamer) then
      table.insert(result, teamer)
    end
  end
  return result
end

function Battle:rangeEnemys(player, distance)
  local allEnemys = self:getPlayers(player.otherSide)
  local result = {}
  for _, enemy in ipairs(allEnemys) do
    if distance >= self:distance(player, enemy) then
      table.insert(result, enemy)
    end
  end
  return result
end

function Battle:pointedPlayer(position, delta)
  local result = {}
  local fakePlayer = {
    xPos = position.x,
    side = position.side
  }
  for _, player in ipairs(self:getPlayers(position.side)) do
    if delta >= self:distance(fakePlayer, player) then
      table.insert(result, player)
    end
  end
  return result
end

function Battle:updateMoveRange(beginXPos, endXpos)
  self.leftBoundary = beginXPos
  self.rightBoundary = endXpos
end

function Battle:distance(playerA, playerB)
  return math.abs(playerA.xPos - playerB.xPos)
end

function Battle:gameOver()
  if self.battleStatus == 1 then
    return false
  end
  if self.battleStatus == 3 then
    return true
  end
  local over = #self.players[SIDE_LEFT] == 0 or #self.players[SIDE_RIGHT] == 0 and self.currentPhase > self.totalPhase
  if self.battleType == BattleType.MJ and not over then
    over = true
    for k, v in pairs(self.players[SIDE_RIGHT]) do
      if v.id == 1 then
        over = false
        break
      end
    end
  end
  self.battleStatus = over and 3 or self.battleStatus
  return over
end

function Battle:initStar()
  local totalHp = 0
  for _, player in ipairs(self:getPlayers(SIDE_LEFT)) do
    totalHp = totalHp + player.hp
  end
  self.starRecord = totalHp
end

function Battle:starResult()
  if #self.players[SIDE_LEFT] == 0 then
    if self.battleType == BattleType.Worldboss then
      return 1
    else
      return 0
    end
  end
  local totalHp = 0
  for _, player in ipairs(self:getPlayers(SIDE_LEFT)) do
    totalHp = totalHp + player.hp
  end
  local percent = totalHp / self.starRecord * 100
  if 70 <= percent then
    return 3
  elseif 40 <= percent then
    return 2
  else
    return 1
  end
end

function Battle:onPause(shipAnimation)
  self.hasPaused = true
  for _, camp in ipairs(self.camps) do
    camp:pause()
  end
  for _, players in ipairs(self.players) do
    for __, player in ipairs(players) do
      player:pause(shipAnimation)
    end
  end
end

function Battle:onResume(shipAnimation)
  self.hasPaused = false
  for _, camp in ipairs(self.camps) do
    camp:resume()
  end
  for _, players in ipairs(self.players) do
    for __, player in ipairs(players) do
      player:resume(shipAnimation)
    end
  end
end

function Battle:handleSyncFrameEvents()
  local function normalEventSide(side)
    if self.battleType == BattleType.Pk_Pvp then
      return side == SIDE_LEFT and SIDE_RIGHT or SIDE_LEFT
    end
    return side
  end
  
  local function doEvent(event)
    local handlers = {
      heroReleaseSkill = function()
        local player = self:getPlayerByIndex(normalEventSide(event.side), event.index)
        if player then
          player:dispatchEvent({
            name = "releaseBlockSkill",
            blockId = event.blockId,
            number = event.number
          })
        end
      end,
      beautyReleaseSkill = function()
        local beauty = self.camps[normalEventSide(event.side)]:getBeautyByIndex(event.index)
        beauty:dispatchEvent({
          name = "beautyReleaseSkill"
        })
      end,
      updateAngryValue = function()
        local beauty = self.camps[normalEventSide(event.side)]:getBeautyByIndex(event.index)
        beauty:addAngryValue({
          number = event.number
        })
      end
    }
    handlers[event.name]()
  end
  
  local newTable = {}
  for tick, events in pairs(self.syncFrameEvents) do
    local eventIndex = 1
    while eventIndex <= #events do
      if tick <= self.currentTime - self.startTime then
        doEvent(events[eventIndex])
        table.remove(events, eventIndex)
      else
        eventIndex = eventIndex + 1
      end
    end
    if #events == 0 then
      self.syncFrameEvents[tick] = nil
    else
      newTable[tick] = events
    end
  end
  self.syncFrameEvents = nil
  self.syncFrameEvents = newTable
end

function Battle:addFrameEvent(event)
  local needSyncBattle = {
    [BattleType.ZoneBoss] = true,
    [BattleType.Pk_Pvp] = true
  }
  if needSyncBattle[self.battleType] then
    event.tick = self.currentTime - self.startTime
    table.insert(self.selfFrameEvents, event)
  end
end

function Battle:sendSelfFrameEvents()
  if #self.selfFrameEvents == 0 then
    return
  end
  local SyncProtols = {
    [BattleType.ZoneBoss] = actionCodes.Boss_frameSync,
    [BattleType.Pk_Pvp] = actionCodes.Pvp_frameSync
  }
  game:sendData(SyncProtols[self.battleType], MsgPack.pack(self.selfFrameEvents))
  self.selfFrameEvents = {}
end

function Battle:update(dt)
  self.currentTime = socket.gettime()
  self.frameTick = self.frameTick + 1
  if not self.hasPaused then
    self.passTime = self.passTime + dt
    self.phasePassTime = self.phasePassTime + dt
  end
  if self:gameOver() then
    for _, player in ipairs(self.origPlayers[SIDE_LEFT]) do
      printInfo("Player naem:%s TotalHurt:%d TotalHurtCnt:%d", player.unit.name, player.totalAttackValue, player.totalHurtCnt)
    end
    self:dispatchEvent({name = "gameOver"})
    return
  end
  self:handleSyncFrameEvents()
  table.sort(self.players[SIDE_LEFT], function(a, b)
    return a.xPos > b.xPos
  end)
  table.sort(self.players[SIDE_RIGHT], function(a, b)
    return a.xPos < b.xPos
  end)
  self.arrangeRowTime = self.arrangeRowTime + dt
  if self.arrangeRowTime > 0.5 then
    self:arrangeZorder()
    self:arrangeRow(SIDE_LEFT)
    self:arrangeRow(SIDE_RIGHT)
    self.arrangeRowTime = 0
  end
  if self.pressurePlate then
    self:updatePlate(dt)
  end
  self.camps[SIDE_LEFT]:update(dt)
  for _, player in ipairs(self.players[SIDE_LEFT]) do
    player:update(dt)
  end
  self.camps[SIDE_RIGHT]:update(dt)
  for _, player in ipairs(self.players[SIDE_RIGHT]) do
    player:update(dt)
  end
  if self.spaceTime ~= 0 and self.totalPhase > self.currentPhase and self.phasePassTime >= self.spaceTime then
    self:dispatchEvent({name = "teamOver"})
  end
  self:sendSelfFrameEvents()
end

function Battle:arrangeZorder()
  local players = {}
  for _, player in ipairs(self.players[SIDE_LEFT]) do
    table.insert(players, player)
  end
  for _, player in ipairs(self.players[SIDE_RIGHT]) do
    table.insert(players, player)
  end
  table.sort(players, function(a, b)
    local yA = math.floor(a.position.y)
    local yB = math.floor(b.position.y)
    if yA == yB then
      local factorA = a.side == SIDE_LEFT and math.floor(a.xPos) or -math.floor(a.xPos)
      local factorB = b.side == SIDE_LEFT and math.floor(b.xPos) or -math.floor(b.xPos)
      if factorA == factorB then
        return a.id < b.id
      end
      return factorA < factorB
    end
    return yA > yB
  end)
  for index, player in ipairs(players) do
    player.zorder = index
    player.displayNode:zorder(index)
  end
end

function Battle:arrangeRow(side)
  local rows = {}
  for index, player in ipairs(self.players[side]) do
    local bmatch = false
    for row, rowPlayers in ipairs(rows) do
      if math.abs(player.xPos - rowPlayers[1].xPos) <= 75 and not player.slave then
        table.insert(rowPlayers, player)
        bmatch = true
        break
      end
    end
    if not bmatch and not player.slave then
      rows[#rows + 1] = {
        [1] = player
      }
    end
  end
  for row, rowPlayers in ipairs(rows) do
    table.sort(rowPlayers, function(a, b)
      return a.zorder > b.zorder
    end)
    local totalCount = #rowPlayers
    local intervalY = 350 / totalCount / 2
    for index, player in ipairs(rowPlayers) do
      if player.hurtMoveBack == 0 then
        player.yMove = BATTLE_Y_POS - (totalCount - 1) * intervalY / 2 + (index - 1) * intervalY
      end
    end
  end
end

function Battle:onGameOver()
  for _, camp in ipairs(self.camps) do
    camp:dispose()
  end
  for index, player in ipairs(self.players[SIDE_LEFT]) do
    player:disposeAllBuff()
  end
  for index, player in ipairs(self.players[SIDE_RIGHT]) do
    player:disposeAllBuff()
  end
end

function Battle:updatePlate(dt)
  for _, plate in ipairs(self.pressurePlate) do
    for __, player in ipairs(self.players[SIDE_LEFT]) do
      local cd = "cd" .. player.id
      if not plate[cd] then
        plate[cd] = 0
      end
      if plate[cd] <= 0 then
        if player.xPos > plate.xBegin and player.xPos < plate.xEnd then
          plate[cd] = plate.interval
          for ___, buff in ipairs(plate.buffs) do
            player:addBuff({buffId = buff, releaser = player})
          end
        end
      else
        plate[cd] = plate[cd] - dt
      end
    end
  end
end

function Battle:setTaste(taste)
  self.taste = taste or self.taste
  self.tastePlayers = {}
  for _, player in ipairs(self.players[SIDE_RIGHT]) do
    if player.taste and player.taste == self.taste and player:getState() ~= "Dead" then
      player:setForceTag(true)
      table.insert(self.tastePlayers, player)
    else
      player:setForceTag(false)
    end
  end
end

function Battle:getTime()
  return self.passTime
end

function Battle:getPhaseTime()
  return self.phasePassTime
end

function Battle:dispose()
  for _, camp in ipairs(self.camps) do
    camp:dispose()
  end
end

return Battle
