local DinerBoxRes = "diner/box/"
local DinerFitRes = "diner/fit/"
local DinerBoxCsv = require("csvdata.diner_box")
local DinerItemCsv = require("csvdata.diner_fitment")
local DinerEntity = import(".DinerEntity")
local DinerBox = class("DinerBox", function()
  return UIHelper.extend(ccui.Layout:create())
end)
local CELL_WIDTH = 100
local CELL_HEIGHT = 50
local WALL_WIDTH = 50
local BOX_MAX_Z = 4

function DinerBox:ctor(params)
  self.params = params or {}
  self.editStatus = EditStatus.normal
  self._entityList = {}
  self._heroList = {}
  self.callRefresh = params.callback or function()
  end
  self:enableNodeEvents()
  self:scheduleUpdate(handler(self, self.update))
  self:init(params)
end

function DinerBox:init(params)
  self.boxData = params.boxData
  self.boxId = params.boxId
  self.isShowReward = params.isShowReward
  self.boxLevel = params.boxLevel or game.role.boxLevel
  self.heroInfo = params.heroInfo or game.role.heros
  if not self.boxData.fitments then
    self.boxData.fitments = {}
  end
  if not self.boxData.wallItems then
    self.boxData.wallItems = {}
  end
  if not self.boxData.rugs then
    self.boxData.rugs = {}
  end
  self._id = 0
  self._content = params.content
  self:initBox()
  self:loadBoxItems()
  self:onBoxShow()
end

function DinerBox:initBox()
  local boxSet = DinerBoxCsv[self.boxData.box][self.boxLevel]
  local mainBg = display.newSprite(DinerBoxRes .. boxSet.bgRes)
  local size = mainBg:getContentSize()
  local width = math.max((display.width + 200) / 0.6, math.floor(size.width / 0.6))
  local height = math.max((display.height + 260 * size.width / size.height) / 0.6, math.floor(size.width / 0.6 * display.height / display.width))
  self:setContentSize(width, height)
  mainBg:center(self):addTo(self)
  self._wall = display.newNode():addTo(mainBg)
  self._ground = display.newNode():addTo(mainBg)
  self._floor = display.newNode():addTo(mainBg)
  self._debugFloor = display.newNode():addTo(mainBg)
  local posX, posY = boxSet.center:match("(%d+)=(%d+)")
  self._cp = cc.p(tonumber(posX), tonumber(posY))
  self._max_x = boxSet.MAX_X
  self._max_y = boxSet.MAX_Y
  self._mapGround = self:createMapData(self._max_x, self._max_y)
  self._mapFloor = self:createMapData(self._max_x, self._max_y)
  local wall = {}
  for mx = 1, self._max_y do
    wall[mx] = {}
    for my = 1, BOX_MAX_Z do
      wall[mx][my] = {}
    end
  end
  for mx = 1, self._max_x do
    wall[-mx] = {}
    for my = 1, BOX_MAX_Z do
      wall[-mx][my] = {}
    end
  end
  self._mapWall = wall
end

function DinerBox:loadBoxItems()
  for _, fitment in ipairs(self.boxData.fitments or {}) do
    fitment._id = self:getNextId()
    local params = clone(fitment)
    params.type = EntityType.fitment
    self:addEntity2Map(params)
  end
  for _, wallItem in ipairs(self.boxData.wallItems or {}) do
    wallItem._id = self:getNextId()
    local params = clone(wallItem)
    params.type = EntityType.wallItem
    self:addEntity2Map(params)
  end
  for _, rug in ipairs(self.boxData.rugs or {}) do
    rug._id = self:getNextId()
    local params = clone(rug)
    params.type = EntityType.rug
    self:addEntity2Map(params)
  end
  self:updateMapStatus()
  for _, heroId in ipairs(self.boxData.heros or {}) do
    if self.heroInfo[heroId] then
      local params = {
        type = EntityType.hero,
        heroType = self.heroInfo[heroId].type,
        heroDress = self.heroInfo[heroId].dress,
        talk = {
          talk = (self.boxData.talk or {})[_],
          talkBg = (self.boxData.talkBg or {})[_]
        }
      }
      local entity = self:addEntity2Map(params)
      table.insert(self._heroList, entity)
      self:updateMapStatus()
    end
  end
end

function DinerBox:addEntity2Map(params)
  params.eventHandler = handler(self, self.entityEventHandler)
  params.content = self:getEntityContent(params.type, {
    side = params.side
  })
  params.boxLogic = self
  local entity = DinerEntity.new(params)
  table.insert(self._entityList, entity)
  return entity
end

function DinerBox:onBoxChange()
  self.editStatus = EditStatus.fitment
  local index = 1
  while index <= #self._entityList do
    local entity = self._entityList[index]
    if entity.type == EntityType.hero then
      entity:removeSelf()
      table.remove(self._entityList, index)
    else
      index = index + 1
    end
  end
  self._heroList = {}
  self:updateMapStatus()
end

function DinerBox:onBoxShow()
  self.editStatus = EditStatus.normal
  if self._currentEntity then
    self._currentEntity:clearStatus()
    self._currentEntity = nil
  end
  self:updateMapStatus()
end

function DinerBox:addItem(itemId)
  local itemSet = DinerItemCsv[itemId]
  local size = cc.size(itemSet.xw, itemSet.yw)
  local pos, extra = self:getRandomPos(itemSet.type, size, itemSet.canflip == 1)
  if not pos then
    SysError(SYS_ERR_DINER_BOX_FULL)
    return false
  end
  local data = {
    item = itemId,
    mx = pos.x,
    my = pos.y
  }
  data._id = self:getNextId()
  if itemSet.type == EntityType.fitment then
    data.flip = extra.flip
    table.insert(self.boxData.fitments, data)
  elseif itemSet.type == EntityType.wallItem then
    data.side = extra.side
    table.insert(self.boxData.wallItems, data)
  elseif itemSet.type == EntityType.rug then
    data.flip = extra.flip
    table.insert(self.boxData.rugs, data)
  end
  local params = clone(data)
  params.type = itemSet.type
  local entity = self:addEntity2Map(params)
  self:updateMapStatus()
  if entity then
    entity:selectEntity()
  end
  return true
end

function DinerBox:cleanBox()
  local index = 1
  while index <= #self._entityList do
    local entity = self._entityList[index]
    if entity.type ~= EntityType.hero then
      self:removeItem(entity)
    else
      index = index + 1
    end
  end
  self._currentEntity = nil
end

function DinerBox:getItemCount(itemId)
  local count = 0
  local itemSet = DinerItemCsv[itemId]
  local data = {}
  if itemSet.type == EntityType.fitment then
    data = self.boxData.fitments
  elseif itemSet.type == EntityType.wallItem then
    data = self.boxData.wallItems
  elseif itemSet.type == EntityType.rug then
    data = self.boxData.rugs
  end
  for _, set in ipairs(data) do
    if set.item == itemId then
      count = count + 1
    end
  end
  return count
end

function DinerBox:getThemeId()
  return self.boxData.box
end

function DinerBox:getBoxData()
  local boxData = {
    heros = {},
    rugs = {},
    fitments = {},
    wallItems = {}
  }
  for _, data in pairs(self._entityList) do
    if data.type == EntityType.fitment then
      local flip = data._bFlip and 1 or 0
      table.insert(boxData.fitments, {
        item = data.item,
        mx = data._mx,
        my = data._my,
        flip = flip
      })
    elseif data.type == EntityType.wallItem then
      table.insert(boxData.wallItems, {
        item = data.item,
        mx = data._mx,
        my = data._my,
        side = data.side
      })
    elseif data.type == EntityType.rug then
      local flip = data._bFlip and 1 or 0
      table.insert(boxData.rugs, {
        item = data.item,
        mx = data._mx,
        my = data._my,
        flip = flip
      })
    end
  end
  for _, heroId in pairs(self.boxData.heros or {}) do
    table.insert(boxData.heros, heroId)
  end
  boxData.box = self.boxData.box
  boxData.id = self.boxData.id
  return boxData
end

function DinerBox:getHotPoint()
  local sum = 0
  for _, entity in ipairs(self._entityList) do
    sum = sum + entity:getHotPoint()
  end
  return sum
end

function DinerBox:getBoxId()
  return self.boxData.box
end

function DinerBox:entityEventHandler(entity, event, params)
  if event == "setPos" then
    self:updateMapStatus()
  end
  if event == "selected" then
    if self._currentEntity then
      if self._currentEntity == entity then
        return
      end
      self._currentEntity:clearStatus()
      self._currentEntity = nil
    end
    self._currentEntity = entity
  end
  if event == "unselected" and self._currentEntity and self._currentEntity == entity then
    self._currentEntity = nil
  end
  if event == "remove" then
    self:removeItem(entity)
    self.callRefresh()
  end
end

function DinerBox:updateMapStatus()
  for mx, data in pairs(self._mapFloor) do
    for my, cell in pairs(data) do
      cell.holdEntity = nil
    end
  end
  for mx, data in pairs(self._mapWall) do
    for my, cell in pairs(data) do
      cell.holdEntity = nil
    end
  end
  for mx, data in pairs(self._mapGround) do
    for my, cell in pairs(data) do
      cell.holdEntity = nil
    end
  end
  for _, entity in ipairs(self._entityList) do
    entity:updateEditStatus()
    if entity.type == EntityType.fitment or entity.type == EntityType.hero and not entity._sitFitment and not entity.bMoving then
      local rect = entity:getBoxRect()
      for i = rect.x, rect.x + rect.width - 1 do
        for j = rect.y, rect.y + rect.height - 1 do
          if self._mapFloor[i] and self._mapFloor[i][j] then
            self._mapFloor[i][j].holdEntity = entity
          end
        end
      end
    end
    if entity.type == EntityType.rug then
      local rect = entity:getBoxRect()
      for i = rect.x, rect.x + rect.width - 1 do
        for j = rect.y, rect.y + rect.height - 1 do
          if self._mapGround[i] and self._mapGround[i][j] then
            self._mapGround[i][j].holdEntity = entity
          end
        end
      end
    end
    if entity.type == EntityType.wallItem then
      local rect = entity:getBoxRect()
      for i = rect.x, rect.x + rect.width - 1 do
        for j = rect.y, rect.y + rect.height - 1 do
          local x, y = i, j
          if entity.side == WallSide.left then
            x = -1 * i
          end
          if self._mapWall[x] and self._mapWall[x][y] then
            self._mapWall[x][y].holdEntity = entity
          end
        end
      end
    end
  end
end

local ctrl = 0

function DinerBox:update(dt)
  ctrl = ctrl + 1
  if ctrl % 2 ~= 0 then
    return
  end
  local floorCount = 0
  for _, entity in ipairs(self._entityList) do
    if entity.status == "selected" or entity.type == EntityType.hero and entity.bMoving then
      entity.bSort = nil
      entity:setOrder(1000)
    elseif entity.type == EntityType.wallItem then
      entity:setOrder(math.abs(entity._mx))
    else
      entity.bSort = true
      if entity.type == EntityType.fitment then
        floorCount = floorCount + 1
      elseif entity.type == EntityType.hero and not entity._sitFitment then
        floorCount = floorCount + 1
      else
        entity:setOrder(0)
      end
    end
  end
  local floorSort = self:sortFloor(floorCount)
  for index, entity in ipairs(floorSort) do
    entity:setOrder(index)
  end
  for _, entity in ipairs(self._entityList) do
    if entity.type == EntityType.hero then
      if self.editStatus == EditStatus.normal then
        entity:show()
        entity:heroUpdate(dt)
      else
        entity:hide()
      end
    end
  end
end

function DinerBox:sortFloor(n)
  local result = {}
  
  local function sortFloorZorder()
    for mx = 1, self._max_x do
      for my = 1, self._max_y do
        local cell = self._mapFloor[mx][my]
        local entity = cell.holdEntity
        if entity and entity.bSort and not entity._sitFitment then
          local rect = entity:getBoxRect()
          if mx < rect.x + rect.width - 1 then
            break
          end
          entity.bSort = nil
          table.insert(result, entity)
          return
        end
      end
    end
  end
  
  local count = 1
  repeat
    sortFloorZorder()
    if count > n * 2 then
      break
    end
    count = count + 1
  until #result == n
  return result
end

function DinerBox:removeItem(entity)
  local data
  if entity.type == EntityType.fitment then
    data = self.boxData.fitments
  elseif entity.type == EntityType.wallItem then
    data = self.boxData.wallItems
  elseif entity.type == EntityType.rug then
    data = self.boxData.rugs
  end
  if not data then
    return
  end
  local hasRemoved = false
  for index, item in ipairs(data) do
    if item._id == entity._id then
      table.remove(data, index)
      hasRemoved = true
      break
    end
  end
  if hasRemoved then
    for _index, _entity in ipairs(self._entityList) do
      if _entity == entity then
        table.remove(self._entityList, _index)
        break
      end
    end
    entity:removeSelf()
  end
  self:updateMapStatus()
end

function DinerBox:getEntityContent(type, params)
  if EntityType.hero == type or EntityType.fitment == type then
    return self._floor
  elseif EntityType.wallItem == type then
    return self._wall
  elseif EntityType.rug == type then
    return self._ground
  end
end

function DinerBox:getOccupy(entity, rect)
  rect = rect or entity:getBoxRect()
  local result = {}
  local canOccupy = true
  local map
  if entity.type == EntityType.fitment or entity.type == EntityType.hero then
    map = self._mapFloor
  elseif entity.type == EntityType.wallItem then
    map = self._mapWall
  elseif entity.type == EntityType.rug then
    map = self._mapGround
  end
  local skipHero = entity.type == EntityType.hero
  for i = rect.x, rect.x + rect.width - 1 do
    result[i] = {}
    for j = rect.y, rect.y + rect.height - 1 do
      local x, y = i, j
      if entity.type == EntityType.wallItem and entity.side == WallSide.left then
        x = -1 * x
      end
      if map[x] and map[x][y] then
        if map[x][y].holdEntity and map[x][y].holdEntity ~= entity then
          canOccupy = false
          result[i][j] = map[x][y].holdEntity
        else
          result[i][j] = false
        end
      else
        canOccupy = false
        result[i][j] = true
      end
    end
  end
  return canOccupy, result
end

function DinerBox:g2m(gx, gy, params)
  params = params or {}
  if params.type == EntityType.fitment or params.type == EntityType.hero or params.type == EntityType.rug then
    gx = gx - self._cp.x
    gy = gy - self._cp.y - CELL_HEIGHT / 2
    local mx = math.round(-0.5 * (gy / CELL_HEIGHT * 2 + gx / CELL_WIDTH * 2))
    local my = math.round(-0.5 * (gy / CELL_HEIGHT * 2 - gx / CELL_WIDTH * 2))
    if not params.noLimit then
      mx = math.max(mx, 1)
      my = math.max(my, 1)
      mx = math.min(mx, self._max_x)
      my = math.min(my, self._max_y)
    end
    return cc.p(mx, my)
  end
  if params.type == EntityType.wallItem then
    local side = params.side or WallSide.right
    local mx, my
    if side == WallSide.right then
      gx = gx - self._cp.x - WALL_WIDTH / 2
      gy = gy - self._cp.y - 13
      mx = math.round(gx / WALL_WIDTH + 1)
      my = math.round(gy / WALL_WIDTH + gx / (2 * WALL_WIDTH) + 1)
    else
      gx = gx - self._cp.x + WALL_WIDTH / 2
      gy = gy - self._cp.y - 13
      mx = math.round(-gx / WALL_WIDTH + 1)
      my = math.round(gy / WALL_WIDTH - gx / (2 * WALL_WIDTH) + 1)
    end
    if not params.noLimit then
      mx = math.max(mx, 1)
      my = math.max(my, 1)
    end
    return cc.p(mx, my)
  end
end

function DinerBox:m2g(mx, my, params)
  params = params or {}
  if params.type == EntityType.fitment or params.type == EntityType.hero or params.type == EntityType.rug then
    local gx = self._cp.x + CELL_WIDTH / 2 * (my - mx)
    local gy = self._cp.y - CELL_HEIGHT / 2 * (mx + my) + CELL_HEIGHT / 2
    return cc.p(gx, gy)
  end
  if params.type == EntityType.wallItem then
    local side = params.side or WallSide.right
    if side == WallSide.right then
      local gx = self._cp.x + WALL_WIDTH * (mx - 1) + WALL_WIDTH / 2
      local gy = self._cp.y - WALL_WIDTH / 2 * (mx - 1) + (my - 1) * WALL_WIDTH + 13
      return cc.p(gx, gy)
    else
      local gx = self._cp.x - WALL_WIDTH * (mx - 1) - WALL_WIDTH / 2
      local gy = self._cp.y - WALL_WIDTH / 2 * (mx - 1) + (my - 1) * WALL_WIDTH + 13
      return cc.p(gx, gy)
    end
  end
end

function DinerBox:getRandomPos(type, size, canflip)
  if EntityType.hero == type then
    local space = {}
    for mx = self._max_x, 1, -1 do
      for my = self._max_y, 1, -1 do
        local rect = cc.rect(mx, my, size.width, size.height)
        local canOccupy, _ = self:getOccupy({type = type}, rect)
        if canOccupy then
          table.insert(space, cc.p(mx, my))
        end
      end
    end
    if 0 < #space then
      return space[math.randomInt(1, #space)]
    end
  end
  if EntityType.fitment == type or EntityType.rug == type then
    if EntityType.fitment == type then
      local leftSpace = self:getLeftSpace()
      if leftSpace - size.width * size.height < 5 then
        return
      end
    end
    for mx = self._max_x, 1, -1 do
      for my = self._max_y, 1, -1 do
        local rect = self:getEntityRect({
          type = type,
          mp = cc.p(mx, my),
          size = size
        })
        local canOccupy, _ = self:getOccupy({type = type}, rect)
        if canOccupy then
          return cc.p(mx, my), {flip = 0}
        end
      end
    end
    if canflip then
      for mx = self._max_x, 1, -1 do
        for my = self._max_y, 1, -1 do
          local rect = self:getEntityRect({
            type = type,
            mp = cc.p(mx, my),
            size = size,
            flip = 1
          })
          local canOccupy, _ = self:getOccupy({type = type}, rect)
          if canOccupy then
            return cc.p(mx, my), {flip = 1}
          end
        end
      end
    end
  end
  if EntityType.wallItem == type then
    for mx = self._max_y, 1, -1 do
      for my = BOX_MAX_Z, 1, -1 do
        local rect = cc.rect(mx, my, size.width, size.height)
        local canOccupy, _ = self:getOccupy({
          type = type,
          side = WallSide.right
        }, rect)
        if canOccupy then
          return cc.p(mx, my), {
            side = WallSide.right
          }
        end
      end
    end
    for mx = self._max_x, 1, -1 do
      for my = BOX_MAX_Z, 1, -1 do
        local rect = cc.rect(mx, my, size.width, size.height)
        local canOccupy, _ = self:getOccupy({
          type = type,
          side = WallSide.left
        }, rect)
        if canOccupy then
          return cc.p(mx, my), {
            side = WallSide.left
          }
        end
      end
    end
  end
end

function DinerBox:getEntityRect(params)
  local flip = params.flip or false
  local type = params.type
  local size = params.size
  local mp = params.mp
  local left = math.huge
  local buttom = math.huge
  if type == EntityType.fitment or type == EntityType.rug then
    for i = 1, size.width do
      for j = 1, size.height do
        if flip then
          left = math.min(left, mp.x - (j - 1))
          buttom = math.min(buttom, mp.y - (i - 1))
        else
          left = math.min(left, mp.x - (i - 1))
          buttom = math.min(buttom, mp.y - (j - 1))
        end
      end
    end
    if flip then
      return cc.rect(left, buttom, size.height, size.width)
    else
      return cc.rect(left, buttom, size.width, size.height)
    end
  elseif self.type == EntityType.wallItem then
    left = mp.x
    buttom = mp.y
    return cc.rect(left, buttom, size.width, size.height)
  elseif self.type == EntityType.hero then
    left = mp.x
    buttom = mp.y
    return cc.rect(left, buttom, size.width, size.height)
  end
end

function DinerBox:getLeftSpace()
  local sum = 0
  for mx = 1, self._max_x do
    for my = 1, self._max_y do
      if not self._mapFloor[mx][my].holdEntity then
        sum = sum + 1
      end
    end
  end
  return sum
end

function DinerBox:getWallSide(x, y)
  if x < self._cp.x then
    return WallSide.left
  else
    return WallSide.right
  end
end

function DinerBox:getNextId()
  self._id = self._id + 1
  return self._id
end

function DinerBox:createMapData(w, h)
  local map = {}
  for mx = 1, w do
    map[mx] = {}
    for my = 1, h do
      map[mx][my] = {}
    end
  end
  return map
end

function DinerBox:getZoom()
  return self._content:getZoomScale()
end

function DinerBox:showReward()
  local rewardTimes = json.decode(game.role.diner.boxReward)[self.boxId] or {}
  local rewardCount = 0
  for _, time in ipairs(rewardTimes) do
    if time <= game:nowTime() then
      rewardCount = rewardCount + 1
    else
      break
    end
  end
  local count = math.min(rewardCount, #self._heroList)
  local had = {}
  for i = 1, count do
    repeat
      local index = math.randomInt(1, #self._heroList)
      if not had[index] then
        had[index] = true
        break
      end
    until false
  end
  for i, hero in pairs(self._heroList) do
    hero:showReward(had[i])
  end
end

function DinerBox:onEnter()
  if self.isShowReward then
    self.handler = game.role:addEventListener("notifyNewMessage", function(event)
      if event.type == "box" then
        self:showReward()
      end
    end)
    self:showReward()
  end
end

function DinerBox:onExit()
  if self.handler then
    game.role:removeEventListener(self.handler)
  end
end

return DinerBox
