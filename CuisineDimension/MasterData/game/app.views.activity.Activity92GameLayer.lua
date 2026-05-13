local ItemCsv = require("csvdata.item")
local GlobalRes = "ui/global/"
local Show92Res = "ui/activity/92/"
local uiData = {
  csbFile = "ui/activity/Activity92GameLayer.csb",
  mask = true,
  widgets = {
    bgSpine = "bgSpine",
    bg = "bg",
    moveLayer = "moveLayer",
    heroLayer = "moveLayer/heroLayer",
    heroNode = "moveLayer/heroNode",
    leftLayer = "leftLayer",
    rightLayer = "rightLayer",
    up = "up"
  }
}
local Activity92GameLayer = class("Activity92GameLayer", UIBase)

function Activity92GameLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function Activity92GameLayer:init(params)
  TopBar:show(TopBarType.hide)
  local spineSkin = UIHelper.createSpineNodeByRes("spine/home_skin/zcys")
  spineSkin:pos(568, 320):addTo(self.bgSpine)
  spineSkin:addAnimation(0, "idle", true)
  self.up:hide()
  self:showHero()
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
  self.gotList = {big = 0, small = 0}
  self.leftLayer:setTouchEnabled(true)
  self.leftLayer:setSwallowTouches(false)
  self.leftLayer:enableNodeEvents()
  self.rightLayer:setTouchEnabled(true)
  self.rightLayer:setSwallowTouches(false)
  self.rightLayer:enableNodeEvents()
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.leftLayer:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  self.rightLayer:addTouchEventListener(function(sender, type)
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
        text = "游戏倒计时:" .. globalCsv.activity92GameTime - math.floor(self.gameTime),
        size = 23
      }):pos(568, 600):addTo(self.bg)
    end
  end, 1)
  self.timeLabel = display.newTTFLabel({
    text = "开始倒计时:" .. dealyStartTime - self.gameTime,
    size = 60
  }):pos(480, 460):addTo(self.moveLayer)
  self.smallBoxCountLabel = display.newTTFLabel({
    text = "小红包：" .. self.gotList.small,
    size = 23
  }):anch(0, 0.5):pos(20, 600):addTo(self.bg)
  self.bigBoxCountLabel = display.newTTFLabel({
    text = "大红包：" .. self.gotList.big,
    size = 23
  }):anch(0, 0.5):pos(20, 560):addTo(self.bg)
end

function Activity92GameLayer:showHero()
  self.heroNode:removeAllChildren()
  self.smallHero = UIHelper.createSpineNodeByRes(globalCsv.activity92moveHero)
  self.smallHero:setAnimation(0, "idle", true)
  self.smallHero:pos(0, -40):scale(0.6, 0.6):addTo(self.heroNode)
  self.heroLayerRect = cc.rect(self.heroLayer:getPositionX() - 35, self.heroLayer:getPositionY(), 50, 90)
end

function Activity92GameLayer:moveLeft()
  if not self.moving then
    self.moving = true
    self.smallHero:setScaleX(-0.6)
    self.smallHero:setAnimation(0, "move", true)
  end
  local posx = self.heroNode:getPositionX() - globalCsv.activity92moveSpeed * 0.03
  posx = math.max(110, posx)
  self.heroNode:setPositionX(posx)
  self.heroLayer:setPositionX(posx)
  self.heroLayerRect = cc.rect(self.heroLayer:getPositionX() - 35, self.heroLayer:getPositionY(), 50, 90)
end

function Activity92GameLayer:moveRight()
  if not self.moving then
    self.moving = true
    self.smallHero:setScaleX(0.6)
    self.smallHero:setAnimation(0, "move", true)
  end
  local posx = self.heroNode:getPositionX() + globalCsv.activity92moveSpeed * 0.03
  posx = math.min(850, posx)
  self.heroNode:setPositionX(posx)
  self.heroLayer:setPositionX(posx)
  self.heroLayerRect = cc.rect(self.heroLayer:getPositionX() - 35, self.heroLayer:getPositionY(), 50, 90)
end

local dealyTime = 0

function Activity92GameLayer:updatePos(dt)
  if not self.startGame then
    return
  end
  if self.startTouch then
    if self.movedir == 1 then
      self:moveLeft()
    elseif self.movedir == 2 then
      self:moveRight()
    end
  end
  if 0.5 <= dealyTime then
    self:createBox()
    dealyTime = 0
  end
  self.gameTime = self.gameTime + dt
  dealyTime = dealyTime + dt
  local time = math.max(0, globalCsv.activity92GameTime - math.floor(self.gameTime))
  if 0 < time then
    self.gameTimeLabel:setString("游戏倒计时:" .. math.max(0, globalCsv.activity92GameTime - math.floor(self.gameTime)))
  else
    self.gameTimeLabel:setString("游戏结算中")
  end
  if self.gameTime > globalCsv.activity92GameTime + 5 then
    self.startGame = false
    self.gameTimeLabel:setString("游戏结算完成")
    self:sendMsg()
    return
  end
  for _, boxData in pairs(self.boxList) do
    if not boxData.disable then
      if boxData.item:getPositionY() > -100 then
        boxData.item:setPositionY(boxData.item:getPositionY() - 3)
        self:checkBoxGet(boxData)
      else
        boxData.item:hide()
      end
    end
  end
end

function Activity92GameLayer:showBoxCount()
  self.smallBoxCountLabel:setString("小红包:" .. self.gotList.small)
  self.bigBoxCountLabel:setString("大红包:" .. self.gotList.big)
end

function Activity92GameLayer:sendMsg()
  game:sendData(actionCodes.Activity_redEnvelopeOpenRpc, MsgPack.pack({
    big = self.gotList.big,
    small = self.gotList.small
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_redEnvelopeOpenRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward,
      callback = function()
        BackManager:pop()
      end
    })
  end)
end

function Activity92GameLayer:onTouchBegan(sender)
  if not self.startGame then
    return
  end
  self.startTouch = true
  if sender == self.leftLayer then
    if self.movedir == 0 then
      self.movedir = 1
    end
  elseif self.movedir == 0 then
    self.movedir = 2
  end
  return true
end

function Activity92GameLayer:onTouchMoved(sender)
end

function Activity92GameLayer:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function Activity92GameLayer:onTouchEnded(sender)
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

function Activity92GameLayer:createBox()
  local isSmall = false
  if math.random(1, 10) > 8 and self.bigBoxNum < globalCsv.activity92BigBox then
    self.bigBoxNum = self.bigBoxNum + 1
  else
    self.smallBoxNum = self.smallBoxNum + 1
    isSmall = true
  end
  if self.smallBoxNum + self.bigBoxNum >= globalCsv.activity92TotalBox and self.bigBoxNum >= globalCsv.activity92BigBox then
    return
  end
  local randX = math.random(110, 790)
  local box = display.newSprite(Show92Res .. (isSmall and "box_2.png" or "box_1.png")):pos(randX, 740):anch(0, 0):addTo(self.moveLayer)
  local data = {
    item = box,
    isSmall = isSmall,
    disable = false
  }
  table.insert(self.boxList, data)
  return box
end

local num = 0

function Activity92GameLayer:checkBoxGet(boxData)
  local boxRect = cc.rect(boxData.item:getPositionX(), boxData.item:getPositionY(), boxData.item:getContentSize().width, boxData.item:getContentSize().height)
  if self:rectsIntersect(boxRect, self.heroLayerRect) and not boxData.disable then
    boxData.disable = true
    boxData.item:hide()
    num = num + 1
    if boxData.isSmall then
      self.gotList.small = self.gotList.small + 1
    else
      self.gotList.big = self.gotList.big + 1
    end
    self:showBoxCount()
  end
end

function Activity92GameLayer:rectsIntersect(rect1, rect2)
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

function Activity92GameLayer:onExit()
  self:unscheduleUpdate()
  scheduler.unscheduleGlobal(self.timerHandler)
end

return Activity92GameLayer
