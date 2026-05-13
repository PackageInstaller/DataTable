local BossRes = "ui/carbon/boss/"
local BossAppearLayer = class("BossAppearLayer", function()
  return display.newLayer()
end)

function BossAppearLayer:ctor(params)
  params = params or {}
  local time = params.time or 2
  local di = UIHelper.newImageView(BossRes .. "main_bg.png"):center(self):addTo(self)
  local eventDispatcher = self:getEventDispatcher()
  local listenner = cc.EventListenerTouchOneByOne:create()
  listenner:setSwallowTouches(true)
  listenner:registerScriptHandler(function(touch, event)
    return true
  end, cc.Handler.EVENT_TOUCH_BEGAN)
  eventDispatcher:addEventListenerWithSceneGraphPriority(listenner, self)
  self.callback = params.callback or function()
  end
  local bg = display.newScale9Sprite(BossRes .. "bg.png", 0, 0, cc.size(display.width, display.height)):center(self):addTo(self)
  self.barWidth = display.width
  self.barHeight = 0
  local centerBar = UIHelper.newImageView(BossRes .. "bar.png")
  local ccsize = centerBar:getContentSize()
  centerBar = display.newScale9Sprite(BossRes .. "bar.png", 0, 0, cc.size(display.width, ccsize.height))
  centerBar:center(self):addTo(self)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(bg)
    UIHelper.fitForiPhoneX(di)
    UIHelper.fitForiPhoneX(centerBar, true)
    bg:setPositionX(bg:getPositionX() - UIHelper.getMoveXForX(true))
    di:setPositionX(di:getPositionX() - UIHelper.getMoveXForX(true))
    centerBar:setPositionX(centerBar:getPositionX() - UIHelper.getMoveXForX(true))
  end
  local topBar = display.newScale9Sprite(BossRes .. "bar.png", 0, 0, cc.size(display.width * 2, self.barHeight))
  local topBatchNode = display.newBatchNode(BossRes .. "warning.png")
  self.topLayer = display.newLayer()
  self.topLayer:pos(0, 175):addTo(centerBar):add(topBatchNode)
  local bottomBatchNode = display.newBatchNode(BossRes .. "warning.png")
  self.bottomLayer = display.newLayer()
  self.bottomLayer:pos(0, 11):addTo(centerBar):add(bottomBatchNode)
  local width, interval = 50, 15
  local num = math.floor(self.barWidth * 5 / (width + interval))
  for index = 1, num do
    display.newSprite(BossRes .. "warning.png"):anch(0, 0.5):scale(1):pos(interval / 2 + (index - 1) * (interval + width), self.barHeight / 2):addTo(topBatchNode)
    display.newSprite(BossRes .. "warning.png"):anch(1, 0.5):scale(-1):pos(self.barWidth - (interval / 2 + (index - 1) * (interval + width)), 0):addTo(bottomBatchNode)
  end
  local lineBatchNode = display.newBatchNode(BossRes .. "line.png")
  self:scheduleUpdate(handler(self, self.step))
  local circle1 = UIHelper.newImageView(BossRes .. "circle_1.png"):pos(250, display.height / 2):addTo(self)
  local circle2 = UIHelper.newImageView(BossRes .. "circle_2.png"):pos(250, display.height / 2):addTo(self)
  circle1:runAction(cc.RepeatForever:create(cc.RotateBy:create(10, 360)))
  circle2:runAction(cc.RepeatForever:create(cc.RotateBy:create(10, -360)))
  UIHelper.newImageView(BossRes .. "head_bg.png"):pos(250, display.height / 2):addTo(self)
  UIHelper.newImageView(BossRes .. "font_bg.png"):pos(700, display.height / 2):addTo(self)
  self:runAction(transition.sequence({
    cc.DelayTime:create(time),
    cc.RemoveSelf:create()
  }))
end

function BossAppearLayer:step(diff)
  self.topLayer:moveBy(diff, -diff * 400, 0)
  self.bottomLayer:moveBy(diff, diff * 400, 0)
end

return BossAppearLayer
