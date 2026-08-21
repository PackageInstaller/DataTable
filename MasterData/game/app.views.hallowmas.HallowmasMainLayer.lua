local MapCsv = require("csvdata.halloween.halloween_maps")
local TaskCsv = require("csvdata.halloween.halloween_task")
local GoalCsv = require("csvdata.halloween.halloween_goal")
local ItemCsv = require("csvdata.item")
local MainRes = "ui/hallowmas/main/"
local TaskRes = "ui/hallowmas/task/"
local uiData = {
  csbFile = "ui/hallowmas/HallowmasMainLayer.csb",
  widgets = {
    up = "up",
    mainBg = "mainBg",
    btnsNode = "btnsNode",
    itemNode = "itemNode",
    node = "node"
  }
}
local btnData = {
  [1] = {
    name = "区域探索",
    red = "",
    func = function(self)
      self:initMap()
    end
  },
  [2] = {
    name = "每日任务",
    red = "task1",
    func = function(self)
      self:showTask()
    end
  },
  [3] = {
    name = "累计奖励",
    red = "task2",
    func = function(self)
      self:showTask2()
    end
  }
}
local HallowmasMainLayer = class("HallowmasMainLayer", UIBase)

function HallowmasMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HallowmasMainLayer:init(params)
  TopBar:show(TopBarType.full, "秘密厨房")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsNode:setPositionX(self.btnsNode:getPositionX() - UIHelper.getMoveXForX())
    self.itemNode:setPositionX(self.itemNode:getPositionX() - UIHelper.getMoveXForX())
    self.node:setPositionX(self.node:getPositionX() - UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.up,
    time = 0.5
  })
  UIHelper.MoveToDown({
    node = self.btnsNode,
    time = 0.5,
    pos = {0, 100}
  })
  UIHelper.MoveToLeft({
    node = self.itemNode,
    time = 0.5,
    pos = {350, 0}
  })
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  self.selected = params.selected or 1
  self.handlers = {}
  self.btns = {}
  self.group = MRadioGroup:create()
  local yPos = -90
  for index, data in ipairs(btnData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {"btn_a.png", "btn_b.png"})
    btn:setName(string.format("index%d", index))
    btn:setGroup(self.group)
    btn:pos(0, yPos):addTo(self.btnsNode)
    btn:setCallback(function()
      self.selected = index
      self:showData()
    end)
    if data.red ~= "" then
      self.btns[data.red] = btn
      local bShow = checkbool(game.role.redPoints.halloween[data.red])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, -14), 0.8)
    end
    display.newTTFLabel({
      text = data.name,
      size = 26
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(74, 32):addTo(btn)
    yPos = yPos - 100
  end
  self.group:chooseByName(string.format("index%d", self.selected))
  self.labels = {}
  yPos = -70
  for _, itemId in ipairs({
    globalCsv.costId1,
    globalCsv.costId2
  }) do
    local countBg = UIHelper.newImageView(MainRes .. "count_bg.png"):anch(1, 0.5):pos(0, yPos):addTo(self.itemNode)
    countBg:setCallback(function()
      MTip:show({
        type = MTipType.path,
        node = countBg,
        itemType = itemId,
        itemData = ItemCsv[itemId]
      })
    end)
    display.newSprite(ItemCsv[itemId].icon):scale(0.6):pos(30, 25):addTo(countBg)
    local lab = display.newTTFLabel({
      text = game.role.items[itemId] or 0,
      size = 30
    }):pos(100, 24):addTo(countBg)
    self.labels[itemId] = lab
    yPos = yPos - 80
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/tower/main/", {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(-30, 10):addTo(self.itemNode)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "common"})
  end)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "halloween" then
      for red, btn in pairs(self.btns) do
        local bShow = checkbool(game.role.redPoints.halloween[red])
        UIHelper.showRedPoint(btn, bShow, cc.p(12, -14), 0.8)
      end
    end
  end))
end

function HallowmasMainLayer:updateCount()
  for itemId, lab in pairs(self.labels) do
    lab:setString(game.role.items[itemId] or 0)
  end
end

function HallowmasMainLayer:showData(params)
  self.node:removeAllChildren()
  if btnData[self.selected] then
    btnData[self.selected].func(self)
  end
end

function HallowmasMainLayer:initMap()
  self.stages = {}
  self.walls = {}
  self.links = {}
  self.paths = game.role.activityStatus["21"].hadStage:toArray("=", true)
  self.map = game.role.activityStatus["21"].curMap
  self.curStage = game.role.activityStatus["21"].curStage
  self.isMoving = false
  local mapBg = display.newSprite(MainRes .. "map_bg.png"):anch(0, 0):pos(-12, 0):addTo(self.node)
  self.refreshMap = UIHelper.extend(ccui.Button:create())
  self.refreshMap:setImages(MainRes, {
    "btn_refresh.png",
    "btn_refresh.png"
  })
  self.refreshMap:pos(800, 35):addTo(self.node)
  self.refreshMap:setTouchScale()
  self.refreshMap:setCallback(function()
    if MapCsv[self.map][self.curStage].type == 2 then
      MDialog:double({
        title = "进入下层",
        text = "即将进入下一层，是否继续？\n（注意:进入下一层后将不可返回）",
        okCallback = function()
          game:sendData(actionCodes.Activity_halloweenResetRpc, MsgPack.pack({}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_halloweenResetRpc, function(event)
            UIHelper.removeWaiting()
            self:showData()
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      if (game.role.items[globalCsv.costId1] or 0) < globalCsv.halloween_refresh_cost then
        SysError(SYS_ERR_HALLOWEEN_CANDLE_NOT_ENOUGH)
        return
      end
      MDialog:double({
        title = "进入下层",
        text = "是否消耗 1 个道具，直接进入下层迷宫？\n（注意:进入下一层后将不可返回）",
        okCallback = function()
          game:sendData(actionCodes.Activity_halloweenResetRpc, MsgPack.pack({}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_halloweenResetRpc, function(event)
            UIHelper.removeWaiting()
            self:showData()
            self:updateCount()
          end)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    end
  end)
  local xPos, yPos = 104, 485
  for row = 1, 4 do
    xPos = 104
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = MapCsv[self.map][index]
      if not data then
        break
      end
      local isPassed = self:isPassedStage(data.posId)
      local cell = UIHelper.newImageView(MainRes .. "cell.png"):pos(xPos, yPos):addTo(mapBg)
      local Wnode = display.newNode():pos(xPos, yPos):addTo(mapBg, 32 + data.posId)
      local Anode = display.newNode():pos(xPos, yPos):addTo(mapBg, 16 + data.posId)
      self.stages[data.posId] = {
        stage = cell,
        wallNode = Wnode,
        arrowNode = Anode,
        pos = {xPos, yPos},
        locat = {row, col}
      }
      self.links[data.posId] = data.neighbor
      if data.type == 3 and not isPassed then
        local nangua = UIHelper.createSpineNodeByRes("spine/ui/halloween/nangua2")
        nangua:setAnimation(0, "special", true)
        nangua:center(cell):addTo(cell):name("image")
        nangua:setScale(nangua:getScale() * 0.7)
        local mask = UIHelper.createSpineNodeByRes("spine/ui/halloween/Halloween")
        mask:setAnimation(0, "idle", true)
        mask:scale(0.9):pos(90, 59):addTo(cell):name("mask")
      elseif data.type == 4 and not isPassed then
        local nangua = UIHelper.createSpineNodeByRes("spine/ui/halloween/nangua1")
        nangua:setAnimation(0, "special", true)
        nangua:center(cell):addTo(cell):name("image")
      elseif data.type == 5 and not isPassed then
        display.newSprite(MainRes .. "image_candle.png"):addTo(cell):center(cell):name("image")
        local mask = UIHelper.createSpineNodeByRes("spine/ui/halloween/Halloween")
        mask:setAnimation(0, "idle", true)
        mask:scale(0.9):pos(90, 59):addTo(cell):name("mask")
      elseif data.type == 1 or data.type == 2 then
        if data.type == 2 then
          display.newSprite(MainRes .. "exit.png"):addTo(Wnode)
        end
        self:createOutIn(data)
      elseif not isPassed then
        local mask = UIHelper.createSpineNodeByRes("spine/ui/halloween/Halloween")
        mask:setAnimation(0, "idle", true)
        mask:scale(0.9):pos(90, 59):addTo(cell):name("mask")
      end
      if self.curStage == 0 and data.type == 1 or self.curStage == data.posId then
        self.curStage = data.posId
        self.player = UIHelper.createSpineNode(36081)
        self.player:scale(0.6):anch(0.5, 0):pos(xPos, yPos - 45):addTo(mapBg, 100)
        self.player:setAnimation(0, "idle", true)
      end
      cell:setCallback(function()
        local dir = self:checkCanMove(data.posId)
        if not dir then
          return
        end
        local isPassed = self:isPassedStage(data.posId)
        
        local function sendMove(costCandy)
          game:sendData(actionCodes.Activity_halloweenMoveRpc, MsgPack.pack({
            stage = data.posId,
            costCandy = costCandy
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_halloweenMoveRpc, function(event)
            UIHelper.removeWaiting()
            if not isPassed then
              table.insert(self.paths, data.posId)
            end
            self.isMoving = true
            self:updateCount()
            local msg = MsgPack.unpack(event.data)
            self:onMove(data.posId, dir, msg.reward, isPassed, costCandy)
          end)
        end
        
        if not isPassed and data.type == 4 and (game.role.items[globalCsv.costId2] or 0) >= globalCsv.costCount2 then
          MDialog:double({
            title = "升级奖励",
            text = "本次奖池要使用道具来升级吗？",
            okCallback = function()
              sendMove(true)
              return true
            end,
            cancelCallback = function()
              sendMove(false)
              return true
            end
          })
        else
          sendMove(false)
        end
      end)
      xPos = xPos + 174
    end
    yPos = yPos - 134
  end
  self:initPath()
end

function HallowmasMainLayer:checkCanMove(endIndex)
  if (game.role.items[globalCsv.costId1] or 0) < globalCsv.costCount1 and not self:isPassedStage(endIndex) then
    SysError(SYS_ERR_HALLOWEEN_CANDLE_NOT_ENOUGH)
    return false
  end
  if self.isMoving then
    return false
  end
  if self.walls[string.format("%d_%d", self.curStage, endIndex)] then
    return false
  end
  local L1 = self.stages[self.curStage].locat
  local L2 = self.stages[endIndex].locat
  local x, y = L2[1] - L1[1], L2[2] - L1[2]
  if math.abs(x) + math.abs(y) ~= 1 then
    return false
  else
    return {y, x}
  end
  return false
end

function HallowmasMainLayer:onMove(endIndex, dir, gift, isPassed, costCandy)
  local stageData = self.stages[endIndex]
  self.player:runAction(transition.sequence({
    cc.CallFunc:create(function()
      if not isPassed then
        local candle = display.newSprite(ItemCsv[globalCsv.costId1].icon):scale(1):pos(60, 96):addTo(self.player)
        candle:setCascadeOpacityEnabled(true)
        display.newTTFLabel({
          text = "-" .. globalCsv.costCount1,
          size = 50,
          color = UIHelper.hex2rgb("#ffff00")
        }):anch(0, 0.5):pos(80, 30):addTo(candle)
        candle:runAction(transition.sequence({
          cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 48))),
          cc.DelayTime:create(0.15),
          cc.RemoveSelf:create()
        }))
        if costCandy then
          local candy = display.newSprite(ItemCsv[globalCsv.costId2].icon):scale(1):pos(60, 0):addTo(self.player)
          candy:setCascadeOpacityEnabled(true)
          display.newTTFLabel({
            text = "-" .. globalCsv.costCount2,
            size = 50,
            color = UIHelper.hex2rgb("#ffff00")
          }):anch(0, 0.5):pos(80, 30):addTo(candy)
          candy:runAction(transition.sequence({
            cc.Spawn:create(cc.FadeIn:create(0.2), cc.MoveBy:create(0.2, cc.p(0, 48))),
            cc.DelayTime:create(0.15),
            cc.RemoveSelf:create()
          }))
        end
      end
      local mask = stageData.stage:getChildByName("mask")
      if mask then
        mask:setAnimation(0, "special", false)
      end
    end),
    cc.DelayTime:create(0.3),
    cc.CallFunc:create(function()
      if dir[1] < 0 then
        self.player:setScaleX(self.player:getScale() * dir[1])
      end
      self.player:setToSetupPose()
      self.player:setTimeScale(3)
      self.player:setAnimation(0, "walk", true)
    end),
    cc.MoveTo:create(0.4, cc.p(stageData.pos[1], stageData.pos[2] - 45)),
    cc.CallFunc:create(function()
      if dir[1] < 0 then
        self.player:setScaleX(0.6)
      end
      self.player:setToSetupPose()
      self.player:setTimeScale(1)
      self.player:setAnimation(0, "idle", true)
      self:createWalls(endIndex, true)
      self.curStage = endIndex
      if MapCsv[self.map][self.curStage].type == 2 then
        MDialog:double({
          title = "到达出口",
          text = "即将进入下一层，是否继续？\n（注意:进入下一层后将不可返回）",
          okCallback = function()
            game:sendData(actionCodes.Activity_halloweenResetRpc, MsgPack.pack({}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_halloweenResetRpc, function(event)
              UIHelper.removeWaiting()
              self:showData()
            end)
            self.isMoving = false
            return true
          end,
          cancelCallback = function()
            self.isMoving = false
            return true
          end
        })
      elseif gift then
        self:cardFlash(endIndex, gift)
      else
        stageData.stage:removeAllChildren()
        self.isMoving = false
      end
    end)
  }))
end

function HallowmasMainLayer:initPath()
  for num, stage in ipairs(self.paths) do
    self:createWalls(stage, stage == self.curStage)
  end
end

function HallowmasMainLayer:isPassedStage(temp)
  for k, id in pairs(self.paths) do
    if temp == id then
      return true
    end
  end
  return false
end

function HallowmasMainLayer:createWalls(index, showArrow)
  local link = self.links[index]:toArray("=", true)
  
  local function isLink(targe)
    for _, value in pairs(link) do
      if value == targe then
        return true
      end
    end
    return false
  end
  
  if showArrow then
    local beginData = self.stages[self.curStage]
    beginData.arrowNode:removeAllChildren()
  end
  local L = self.stages[index].locat
  local rows = {
    L[1] - 1,
    L[1] + 1
  }
  for type, row in ipairs(rows) do
    local temp = (row - 1) * 4 + L[2]
    local stage = self.stages[temp]
    if stage and not isLink(temp) then
      local line = self:createLine(1)
      line:pos(0, type == 1 and 67 or -67):addTo(self.stages[index].wallNode)
      self.walls[string.format("%d_%d", index, temp)] = true
    end
    if showArrow and stage and isLink(temp) then
      local arrow = self:createArrow(type)
      arrow:pos(0, type == 1 and 67 or -67):addTo(self.stages[index].arrowNode)
    end
  end
  local cols = {
    L[2] - 1,
    L[2] + 1
  }
  for type, col in ipairs(cols) do
    local temp = (L[1] - 1) * 4 + col
    local stage = self.stages[temp]
    if stage and not isLink(temp) and (type ~= 1 or L[2] ~= 1) and (type ~= 2 or L[2] ~= 4) then
      local line = self:createLine(2)
      line:pos(type == 1 and -87 or 87, 0):addTo(self.stages[index].wallNode)
      self.walls[string.format("%d_%d", index, temp)] = true
    end
    if showArrow and stage and isLink(temp) then
      local arrow = self:createArrow(type + 2)
      arrow:pos(type == 1 and -87 or 87, 0):addTo(self.stages[index].arrowNode)
    end
  end
end

function HallowmasMainLayer:createLine(type)
  local line = display.newSprite(MainRes .. string.format("line_%d.png", type))
  display.newSprite(MainRes .. "point.png"):pos(type == 1 and -4 or 3, type == 1 and 3 or -3):addTo(line)
  display.newSprite(MainRes .. "point.png"):pos(type == 1 and 169 or 3, type == 1 and 3 or 130):addTo(line)
  return line
end

function HallowmasMainLayer:createArrow(type)
  local rotate = {
    -90,
    90,
    -180,
    0
  }
  local arrow = display.newSprite(MainRes .. "arrow.png")
  arrow:setRotation(rotate[type])
  return arrow
end

function HallowmasMainLayer:createOutIn(data)
  local stageData = self.stages[data.posId]
  local L = stageData.locat
  local xPos, yPos, rotate = 0, 73, 90
  if L[1] == 1 then
    rotate = -90
    yPos = 73
  elseif L[1] == 4 then
    yPos = -73
  else
    yPos = 0
    if L[2] == 1 then
      rotate = 180
      xPos = -95
    elseif L[2] == 4 then
      rotate = 0
      xPos = 95
    end
  end
  local move = {
    [90] = {0, 5},
    [-90] = {0, 5},
    [180] = {5, 0},
    [0] = {5, 0}
  }
  local line = display.newSprite(MainRes .. "out_in.png"):pos(xPos, yPos):setRotation(rotate):addTo(stageData.wallNode)
  local dir = move[rotate]
  local x, y = dir[1], dir[2]
  if data.type == 1 then
    line:setScale(-1)
    x, y = -dir[1], -dir[2]
  end
  line:runAction(cc.RepeatForever:create(transition.sequence({
    cc.MoveBy:create(0.2, cc.p(x, y)),
    cc.MoveBy:create(0.4, cc.p(-2 * x, -2 * y)),
    cc.MoveBy:create(0.2, cc.p(x, y))
  })))
end

function HallowmasMainLayer:cardFlash(index, items)
  local stageData = self.stages[index]
  local flash = display.newSprite(MainRes .. "flash.png"):center(stageData.stage):addTo(stageData.stage)
  flash:setOpacity(0)
  flash:runAction(transition.sequence({
    cc.FadeIn:create(0.06),
    cc.FadeOut:create(0.18),
    cc.CallFunc:create(function()
      MedalRewardLayer.new({
        items = items,
        callback = function()
          self.isMoving = false
        end
      })
      stageData.stage:removeAllChildren()
    end)
  }))
end

function HallowmasMainLayer:showTask()
  local taskBg = display.newSprite(TaskRes .. "task_bg.png"):pos(-3, 0):anch(0, 0):pos(-12, 0):addTo(self.node)
  local tLabel = display.newTTFLabel({
    text = "每日任务 00:00:00后刷新",
    size = 20,
    color = UIHelper.hex2rgb("#3b1804")
  }):anch(0, 0.5):pos(10, 547):addTo(taskBg)
  local tT = CommonHelper.date(game:nowTime() + 86400)
  local endTime = CommonHelper.time({
    year = tT.year,
    month = tT.month,
    day = tT.day,
    hour = 4
  })
  
  local function refreshTime()
    local left = (endTime - game:nowTime()) % 86400
    if 0 < left then
      tLabel:setString("每日任务 " .. UIHelper.getTimeStr(left) .. "后刷新")
      tLabel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          refreshTime()
        end)
      }))
    else
      self:showData()
    end
  end
  
  refreshTime()
  local list = ccui.ListView:create()
  list:size(cc.size(710, 528))
  list:setInnerContainerSize(cc.size(710, 528))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(8, 4):addTo(taskBg)
  local sortData = {}
  local taskStatusOld = game.role.activityStatus["21"].taskStatus:toNumMap()
  local taskStatus = {}
  local curDay = 0
  for tempId, value in pairs(taskStatusOld) do
    local id = 0
    curDay, id = math.floor(tempId / 1000), tempId % 1000
    taskStatus[id] = value
  end
  for id, value in pairs(taskStatus) do
    local data = TaskCsv[curDay][id]
    if data and data.pre ~= 0 then
      if taskStatus[data.pre] == -1 then
        taskStatus[data.pre] = nil
      else
        taskStatus[id] = nil
      end
    end
  end
  for id, value in pairs(taskStatus) do
    local data = TaskCsv[curDay][id]
    local temp = clone(data)
    temp.value = value
    temp.status = value == -1 and -1 or value >= data.condition1 and 1 or 0
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    return a.order - 100 * a.status < b.order - 100 * b.status
  end)
  local cellSize = cc.size(710, 106)
  local rows = math.ceil(#sortData / 2)
  local xPos = 176
  for row = 1, rows do
    xPos = 176
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    for col = 1, 2 do
      local data = sortData[(row - 1) * 2 + col]
      if not data then
        break
      end
      local cell = UIHelper.newImageView(TaskRes .. "cell.png"):pos(xPos, 55):addTo(viewNode)
      display.newTTFLabel({
        text = data.desc,
        size = 20,
        color = UIHelper.hex2rgb("#FFFFFF")
      }):anch(0, 0.5):pos(20, 76):addTo(cell):enableOutline(UIHelper.hex2rgb("#000000"), 1)
      local x = 25
      local gift = data.gift:toTableArray()
      for _, temp in ipairs(gift) do
        display.newSprite(ItemCsv[tonumber(temp[1])].icon):scale(0.4):pos(x, 25):addTo(cell)
        display.newTTFLabel({
          text = "x" .. temp[2],
          size = 22
        }):enableOutline(UIHelper.hex2rgb("#3b1804"), 1):anch(0, 0.5):pos(x + 15, 25):addTo(cell)
        x = x + 70
      end
      local done = data.value == -1
      if done then
        display.newSprite(TaskRes .. "image_done.png"):pos(250, 25):addTo(cell)
      else
        if data.type == 107 then
          data.value = 1
          data.condition1 = 1
        end
        display.newTTFLabel({
          text = string.format("%d/%d", data.value, data.condition1),
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#3b1804"), 1):pos(280, 55):addTo(cell)
        local btn = UIHelper.extend(ccui.Button:create()):pos(285, 25):addTo(cell)
        if data.value < data.condition1 then
          btn:setImages(TaskRes, {"btn_a.png", "btn_a.png"})
          cell:setCallback(function()
            self:showForward(data)
          end)
          btn:setCallback(function()
            self:showForward(data)
          end)
          display.newTTFLabel({text = "前往", size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(44, 17):addTo(btn)
        else
          display.newTTFLabel({text = "领取", size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(46, 17):addTo(btn)
          btn:setImages(TaskRes, {"btn_b.png", "btn_b.png"})
          btn:setCallback(function()
            game:sendData(actionCodes.Activity_halloweenRewardRpc, MsgPack.pack({
              id = data.time * 1000 + data.id,
              tastType = 1
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_halloweenRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              btn:removeSelf()
              display.newSprite(TaskRes .. "image_done.png"):pos(250, 25):addTo(cell)
              MedalRewardLayer.new({
                items = msg.reward
              })
              self:showData()
              self:updateCount()
            end)
          end)
        end
      end
      xPos = xPos + 345
    end
  end
  list:requestDoLayout()
end

function HallowmasMainLayer:showTask2()
  local goalBg = display.newSprite(TaskRes .. "goal_bg.png"):anch(0, 0):addTo(self.node):pos(-12, 425)
  display.newTTFLabel({
    text = GoalCsv[1].desc or textByKey("hallow_dec_1"),
    size = 20,
    color = UIHelper.hex2rgb("#3b1804")
  }):anch(0, 0.5):pos(10, 120):addTo(goalBg)
  local barBg = display.newSprite(TaskRes .. "bar_bg.png"):anch(0, 0):pos(15, 40):addTo(goalBg)
  local bar = display.newProgressTimer(TaskRes .. "bar_core.png", 1):center(barBg):addTo(barBg)
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  local status = game.role.activityStatus["21"].goalTask or ""
  local all, longth = GoalCsv[#GoalCsv].condition, bar:getContentSize().width
  local curNum = status:getv(0, 0)
  bar:setPercentage(curNum / all * 100)
  display.newTTFLabel({
    text = string.format("当前次数: %d", curNum),
    size = 20,
    color = UIHelper.hex2rgb("#3b1804")
  }):anch(0, 0.5):pos(525, 120):addTo(goalBg)
  for id, data in ipairs(GoalCsv) do
    local xPos = data.condition / all * longth - 10
    local temp = status:getv(id, 0)
    display.newTTFLabel({
      text = string.format("%d次", data.condition),
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(xPos, -16):addTo(bar)
    if id < #GoalCsv then
      display.newSprite(TaskRes .. "image_line.png"):anch(0.5, 0):pos(xPos + 10, 0):addTo(bar)
    end
    local cell = UIHelper.newImageView(TaskRes .. "bar_one.png"):pos(xPos, 29):addTo(bar)
    if temp == -1 then
      display.newSprite(TaskRes .. "done.png"):pos(xPos, 29):addTo(bar)
      cell:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end)
    elseif curNum >= data.condition then
      display.newSprite(TaskRes .. "can_get.png"):pos(xPos, 29):addTo(bar)
      cell:setCallback(function()
        game:sendData(actionCodes.Activity_halloweenRewardRpc, MsgPack.pack({
          id = data.id,
          tastType = 3
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_halloweenRewardRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          MedalRewardLayer.new({
            items = msg.reward
          })
          self:showData()
          self:updateCount()
        end)
      end)
    else
      cell:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end)
    end
  end
  local taskBg = display.newSprite(TaskRes .. "task_bg2.png"):anch(0, 0):pos(-12, 0):addTo(self.node)
  local list = ccui.ListView:create()
  list:size(cc.size(690, 410))
  list:setInnerContainerSize(cc.size(690, 410))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(15, 5):addTo(taskBg)
  local sortData = {}
  local taskStatus = game.role.activityStatus["21"].otherTask:toNumMap()
  for taskId, data in pairs(TaskCsv[0]) do
    taskStatus[taskId] = taskStatus[taskId] or 0
  end
  for id, value in pairs(taskStatus) do
    local data = TaskCsv[0][id]
    if data and data.pre ~= 0 then
      if taskStatus[data.pre] == -1 then
        taskStatus[data.pre] = nil
      else
        taskStatus[id] = nil
      end
    end
  end
  for id, value in pairs(taskStatus) do
    local data = TaskCsv[0][id]
    local temp = clone(data)
    temp.value = value
    temp.status = value == -1 and -1 or value >= data.condition1 and 1 or 0
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    return a.order - 100 * a.status < b.order - 100 * b.status
  end)
  local cellSize = cc.size(690, 106)
  local rows = math.ceil(#sortData / 2)
  local xPos = 168
  for row = 1, rows do
    xPos = 168
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    for col = 1, 2 do
      local data = sortData[(row - 1) * 2 + col]
      if not data then
        break
      end
      local cell = UIHelper.newImageView(TaskRes .. "cell.png"):pos(xPos, 55):addTo(viewNode)
      display.newTTFLabel({
        text = data.desc,
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#3b1804"), 1):anch(0, 0.5):pos(20, 75):addTo(cell)
      local x = 25
      local gift = data.gift:toTableArray()
      for _, temp in ipairs(gift) do
        display.newSprite(ItemCsv[tonumber(temp[1])].icon):scale(0.4):pos(x, 25):addTo(cell)
        display.newTTFLabel({
          text = "x" .. temp[2],
          size = 22
        }):enableOutline(UIHelper.hex2rgb("#3b1804"), 1):anch(0, 0.5):pos(x + 15, 25):addTo(cell)
        x = x + 70
      end
      local done = data.value == -1
      if done then
        display.newSprite(TaskRes .. "image_done.png"):pos(280, 25):addTo(cell)
      else
        local curV, allV = data.value, data.condition1
        if data.type == 104 or data.type == 105 then
          local t = ""
          t, curV = string.gsub(tostring(curV), "1", "1")
          t, allV = string.gsub(tostring(allV), "1", "1")
        end
        display.newTTFLabel({
          text = string.format("%d/%d", curV, allV),
          size = 20
        }):enableOutline(UIHelper.hex2rgb("#3b1804"), 1):pos(280, 55):addTo(cell)
        local btn = UIHelper.extend(ccui.Button:create()):pos(285, 25):addTo(cell)
        if data.value < data.condition1 then
          btn:setImages(TaskRes, {"btn_a.png", "btn_a.png"})
          cell:setCallback(function()
            self:showForward(data)
          end)
          btn:setCallback(function()
            self:showForward(data)
          end)
          display.newTTFLabel({text = "前往", size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(44, 17):addTo(btn)
        else
          display.newTTFLabel({text = "领取", size = 18}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(46, 17):addTo(btn)
          btn:setImages(TaskRes, {"btn_b.png", "btn_b.png"})
          btn:setCallback(function()
            game:sendData(actionCodes.Activity_halloweenRewardRpc, MsgPack.pack({
              id = data.id,
              tastType = 2
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Activity_halloweenRewardRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              btn:removeSelf()
              display.newSprite(TaskRes .. "image_done.png"):pos(250, 25):addTo(cell)
              MedalRewardLayer.new({
                items = msg.reward
              })
              self:showData()
              self:updateCount()
            end)
          end)
        end
      end
      xPos = xPos + 345
    end
  end
  list:requestDoLayout()
end

function HallowmasMainLayer:showForward(data)
  local jumpType = data.type
  local cond = 0
  if data.type == 101 or data.type == 105 then
    self.selected = 1
    self:showData()
    self.group:chooseByName(string.format("index%d", self.selected))
    return
  end
  if data.type == 102 then
    jumpType = 5
  elseif data.type == 103 then
    jumpType = 0
    cond = 71
  elseif data.type == 109 then
    jumpType = 40
  elseif data.type == 104 then
    jumpType = 21
  elseif data.type == 108 then
    jumpType = 0
    cond = 10
  elseif data.type == 106 then
    jumpType = 40
  elseif data.type == 110 then
    jumpType = 0
    cond = 56
  elseif data.type == 111 then
  elseif data.type == 112 then
    jumpType = 0
    cond = 56
  elseif data.type == 113 or data.type == 114 then
    jumpType = 0
    cond = 42
  elseif data.type == 115 then
    jumpType = 5
  elseif data.type == 116 then
    jumpType = 0
    cond = 42
  end
  CommonHelper.jumpLayer(jumpType, function()
    self:hide()
  end, function()
    TopBar:show(TopBarType.full, "秘密厨房")
    self:show()
    self:showData()
    game:playMusic(3)
  end, cond)
end

function HallowmasMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

function HallowmasMainLayer:checkMaps()
  for _, map in ipairs(MapCsv) do
    for _, stage in ipairs(map) do
      for _, stageId in pairs(stage.neighbor:toArray("=", true)) do
        local connect = false
        for _, tempId in pairs(map[stageId].neighbor:toArray("=", true)) do
          if tempId == stage.posId then
            connect = true
            break
          end
        end
        if not connect then
          print(string.format("ERROR!!! map %d, %d is not connect with %d", map[stageId].mapId, stageId, stage.posId))
        end
      end
    end
  end
end

return HallowmasMainLayer
