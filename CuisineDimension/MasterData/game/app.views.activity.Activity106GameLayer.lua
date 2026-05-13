local ItemCsv = require("csvdata.item")
local UnitCsv = require("csvdata.unit")
local activity106ItemCsv = require("csvdata.activity_106_item")
local GlobalRes = "ui/global/"
local Show92Res = "ui/activity/106/"
local uiData = {
  csbFile = "ui/activity/Activity106GameLayer.csb",
  mask = true,
  widgets = {
    bgSpine = "bgSpine",
    bg = "bg",
    moveLayer = "moveLayer",
    heroLayer = "moveLayer/heroLayer",
    heroNode = "moveLayer/heroNode",
    upLayer = "upLayer",
    downLayer = "downLayer",
    up = "up"
  }
}
local Activity106GameLayer = class("Activity106GameLayer", UIBase)

function Activity106GameLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function Activity106GameLayer:init(params)
  TopBar:show(TopBarType.hide)
  self.heroId = params.heroId
  UIHelper.newImageView(Show92Res .. "game_bg.png"):pos(568, 320):addTo(self.bg)
  self.up:hide()
  self:scheduleUpdate(handler(self, self.updatePos))
  self.startTouch = false
  self.touchDaily = 0
  self.movedir = 0
  self.moving = false
  self.smallBoxNum = 0
  self.bigBoxNum = 0
  self.gameTime = 0
  self.startGame = false
  self.boxList = {}
  self.missCount = 0
  local hero = game.role.heros[self.heroId]
  local unit = UnitCsv[hero:getDressType()]
  self.profession = unit.profession
  self.hp = 3
  if self.profession == 1 then
    self.hp = 6
  end
  if self.profession == 5 then
    self.missCount = 10
  end
  self:showHero(self.heroId)
  self.heroLayer:setPositionX(120)
  self.heroNode:setPositionX(120)
  self.upLayer:setPositionX(92)
  self.upLayer:setTouchEnabled(true)
  self.upLayer:setSwallowTouches(false)
  self.upLayer:enableNodeEvents()
  self.downLayer:setTouchEnabled(true)
  self.downLayer:setSwallowTouches(false)
  self.downLayer:enableNodeEvents()
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.upLayer:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  self.downLayer:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  local dealyStartTime = 3
  self.timerHandler = scheduler.scheduleGlobal(function()
    self.gameTime = self.gameTime + 1
    if self.timeLabel then
      self.timeLabel:setString("开始倒计时:" .. dealyStartTime - self.gameTime)
    end
    if self.gameTime == dealyStartTime then
      self.startGame = true
      self.gameTime = 0
      scheduler.unscheduleGlobal(self.timerHandler)
      self.timeLabel:removeSelf()
      self.gameTimeLabel = display.newTTFLabel({
        text = "游戏倒计时:" .. globalCsv.activity106GameTime - math.floor(self.gameTime),
        size = 23
      }):enableOutline(UIHelper.hex2rgb("#2ca2ec"), 2):pos(568, 600):addTo(self.bg)
    end
  end, 1)
  self.timeLabel = display.newTTFLabel({
    text = "开始倒计时:" .. dealyStartTime - self.gameTime,
    size = 60
  }):enableOutline(UIHelper.hex2rgb("#2ca2ec"), 2):pos(480, 460):addTo(self.moveLayer)
  self.missCountLabel = display.newTTFLabel({
    text = "躲避数量：" .. self.missCount,
    size = 23
  }):enableOutline(UIHelper.hex2rgb("#2ca2ec"), 2):anch(0, 0.5):pos(20, 600):addTo(self.bg)
  self.hpLabel = display.newTTFLabel({
    text = "生命数量：" .. self.hp,
    size = 23
  }):enableOutline(UIHelper.hex2rgb("#2ca2ec"), 2):anch(0, 0.5):pos(20, 560):addTo(self.bg)
end

function Activity106GameLayer:showHero(heroId)
  local hero = game.role.heros[heroId]
  local unit = UnitCsv[hero:getDressType()]
  self.heroNode:removeAllChildren()
  local offsetScale = self.profession == 4 and 0.75 or self.profession == 6 and 0.9 or 1
  print("offsetScale:", offsetScale)
  self.smallHero = UIHelper.createSpineNodeByRes(unit.boneRes)
  self.smallHero:setAnimation(0, "idle", true)
  self.smallHero:pos(0, 0):scale(0.6 * offsetScale, 0.6 * offsetScale):addTo(self.heroNode)
  self.heroLayerRect = cc.rect(self.heroLayer:getPositionX() - 35 * offsetScale, self.heroLayer:getPositionY(), 45 * offsetScale, 80 * offsetScale)
end

function Activity106GameLayer:moveUp()
  if not self.moving then
    self.moving = true
    self.smallHero:setAnimation(0, "move", true)
  end
  local speedAdd = self.profession == 3 and 1.5 or self.profession == 6 and 1.25 or 1
  local posy = self.heroNode:getPositionY() + globalCsv.activity106moveSpeed * 0.03 * speedAdd
  posy = math.min(520, posy)
  self.heroNode:setPositionY(posy)
  self.heroLayer:setPositionY(posy)
  local offsetScale = self.profession == 4 and 0.75 or self.profession == 6 and 0.9 or 1
  self.heroLayerRect = cc.rect(self.heroLayer:getPositionX() - 35 * offsetScale, self.heroLayer:getPositionY(), 45 * offsetScale, 80 * offsetScale)
end

function Activity106GameLayer:moveDown()
  if not self.moving then
    self.moving = true
    self.smallHero:setAnimation(0, "move", true)
  end
  local speedAdd = self.profession == 3 and 1.5 or self.profession == 6 and 1.25 or 1
  local posy = self.heroNode:getPositionY() - globalCsv.activity106moveSpeed * 0.03 * speedAdd
  posy = math.max(20, posy)
  self.heroNode:setPositionY(posy)
  self.heroLayer:setPositionY(posy)
  local offsetScale = self.profession == 4 and 0.75 or self.profession == 6 and 0.9 or 1
  self.heroLayerRect = cc.rect(self.heroLayer:getPositionX() - 35 * offsetScale, self.heroLayer:getPositionY(), 45 * offsetScale, 80 * offsetScale)
end

local dealyTime = 0
local watiTime = 0.5
local lastGameTime = 0

function Activity106GameLayer:updatePos(dt)
  if not self.startGame then
    return
  end
  if self.startTouch then
    if self.movedir == 1 then
      self:moveUp()
    elseif self.movedir == 2 then
      self:moveDown()
    end
  end
  if dealyTime >= watiTime then
    self:createBox()
    if self.gameTime > 15 then
      watiTime = 0.4
    end
    if self.gameTime > 20 then
      watiTime = 0.3
    end
    dealyTime = 0
  end
  self.gameTime = self.gameTime + dt
  dealyTime = dealyTime + dt
  local tempGameTime = math.floor(self.gameTime)
  if self.profession == 2 and 1 < self.gameTime and lastGameTime ~= tempGameTime and tempGameTime % 7 == 0 then
    lastGameTime = tempGameTime
    self.hp = self.hp + 1
    self.hpLabel:setString("生命数量：" .. self.hp)
  end
  local time = math.max(0, globalCsv.activity106GameTime - math.floor(self.gameTime))
  if 0 < time then
    self.gameTimeLabel:setString("游戏倒计时:" .. math.max(0, globalCsv.activity106GameTime - math.floor(self.gameTime)))
  else
    self.gameTimeLabel:setString("游戏结算中")
  end
  if self.gameTime > globalCsv.activity106GameTime + 0.5 then
    self.startGame = false
    self.gameTimeLabel:setString("游戏结算完成")
    for _, boxData in pairs(self.boxList) do
      boxData.item:removeSelf()
      boxData.disable = true
    end
    self:sendMsg()
    return
  end
  for _, boxData in pairs(self.boxList) do
    if not boxData.disable then
      if boxData.item:getPositionX() > -150 then
        local speedRate = 1
        if self.gameTime > 15 then
          speedRate = 1.5
        end
        if self.gameTime > 20 then
          speedRate = 2.5
        end
        boxData.item:setPositionX(boxData.item:getPositionX() - 3 * speedRate)
        self:checkBoxGet(boxData)
      else
        boxData.item:removeSelf()
        boxData.disable = true
        self.missCount = self.missCount + 1
        self.missCountLabel:setString("躲避数量：" .. self.missCount)
        boxData.disable = true
      end
    end
  end
end

function Activity106GameLayer:checkBoxGet(boxData)
  local boxRect = cc.rect(boxData.item:getPositionX(), boxData.item:getPositionY(), 55, 55)
  if self:rectsIntersect(boxRect, self.heroLayerRect) and not boxData.disable then
    boxData.disable = true
    boxData.item:removeSelf()
    self.hp = self.hp - 1
    self.hpLabel:setString("生命数量：" .. self.hp)
    if self.hp <= 0 then
      self.startGame = false
      self.gameTimeLabel:setString("游戏结算完成")
      self:sendMsg()
      return
    end
  end
end

function Activity106GameLayer:sendMsg()
  print("sendMsg self.missCount:", self.missCount)
  game:sendData(actionCodes.Activity_act106GameOverRpc, MsgPack.pack({
    count = self.missCount
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act106GameOverRpc, function(event)
    UIHelper.removeWaiting()
    MDialog:single({
      title = "提示",
      text = "游戏结束，返回活动页"
    }, function()
      BackManager:pop()
    end)
  end)
end

function Activity106GameLayer:onTouchBegan(sender)
  if not self.startGame then
    return
  end
  self.startTouch = true
  if sender == self.upLayer then
    if self.movedir == 0 then
      self.movedir = 1
    end
  elseif self.movedir == 0 then
    self.movedir = 2
  end
  return true
end

function Activity106GameLayer:onTouchMoved(sender)
end

function Activity106GameLayer:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function Activity106GameLayer:onTouchEnded(sender)
  if not self.startGame then
    return
  end
  self.movedir = 0
  self.startTouch = false
  self.touchDaily = 0
  self.moving = false
  self.smallHero:setToSetupPose()
  self.smallHero:setAnimation(0, "idle", true)
end

function Activity106GameLayer:createBox()
  local randY = math.random(0, 540)
  local randIndex = math.random(1, #activity106ItemCsv)
  local itemData = activity106ItemCsv[randIndex]
  local box = display.newSprite(itemData.resPath):pos(1236, randY):anch(0, 0):scale(0.15, 0.15):addTo(self.moveLayer)
  local data = {item = box, disable = false}
  table.insert(self.boxList, data)
  return box
end

function Activity106GameLayer:rectsIntersect(rect1, rect2)
  local rect1Left = rect1.x
  local rect1Right = rect1.x + rect1.width
  local rect1Top = rect1.y
  local rect1Bottom = rect1.y + rect1.height
  local rect2Left = rect2.x
  local rect2Right = rect2.x + rect2.width
  local rect2Top = rect2.y
  local rect2Bottom = rect2.y + rect2.height
  return not (rect1Right < rect2Left) and not (rect1Left > rect2Right) and not (rect1Bottom < rect2Top) and not (rect1Top > rect2Bottom)
end

function Activity106GameLayer:onExit()
  self:unscheduleUpdate()
  scheduler.unscheduleGlobal(self.timerHandler)
end

return Activity106GameLayer
