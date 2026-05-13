local uiData = {
  csbFile = "ui/kitchen/ChengLayer.csb",
  widgets = {
    tray = "tray",
    value = "tray/value",
    sub = "bottom/sub",
    add = "bottom/add",
    touch = "bottom/touch",
    hander = "bottom/touch/hander"
  }
}
local ChengLayer = class("ChengLayer", UIBase)

function ChengLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChengLayer:init(params)
  self:pos(0, -450)
  self.num = params.value
  self.originPos = {
    x = self.hander:getPositionX(),
    y = self.hander:getPositionY()
  }
  local flash = display.newSprite("ui/kitchen/cook/flash.png"):center(self.hander):addTo(self.hander)
  flash:runAction(cc.RepeatForever:create(transition.sequence({
    cc.FadeOut:create(1),
    cc.FadeIn:create(1)
  })))
  self.touch:setTouchEnabled(true)
  self.touch:enableNodeEvents()
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.touch:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  self.sub:setCallback(function()
    self:changeValue(-1)
  end)
  self.add:setCallback(function()
    self:changeValue(1)
  end)
  local value = tonumber(self.num:getString())
  self:valueToRotate(value)
  self.jump = false
  self.times = 0
  
  local function addFunc()
    self.times = self.times and self.times or 0
    self.times = self.times + 1
    if self.times > 1 then
      self:changeValue(1)
    end
  end
  
  self.add:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      addFunc()
    end, 0.2)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self.times = 2
    addFunc()
    self.times = 0
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self.times = 2
    addFunc()
    self.times = 0
  end)
  
  local function subFunc()
    self.times = self.times and self.times or 0
    self.times = self.times + 1
    if self.times > 1 then
      self:changeValue(-1)
    end
  end
  
  self.sub:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      subFunc()
    end, 0.2)
  end, nil, function()
    scheduler.unscheduleGlobal(self.addHandler)
    self.times = 2
    subFunc()
    self.times = 0
  end, function()
    scheduler.unscheduleGlobal(self.addHandler)
    self.times = 2
    subFunc()
    self.times = 0
  end)
end

function ChengLayer:showData(params)
  if game.role.majorGuideStep == 14 then
    self.mask1 = UIHelper.newMask({
      size = cc.size(display.width, 315)
    }):anch(0, 1):pos(0, display.height):addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER)
    self.mask2 = UIHelper.newMask({
      size = cc.size(150, display.height)
    }):anch(1, 0):pos(display.width, 0):addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER)
    if UIHelper.isiPhoneX() then
      self.mask1:setScaleX(UIHelper.getScaleForX())
      self.mask2:setPositionX(self.mask2:getPositionX() + UIHelper.getMoveXForX() * 2)
    end
    self.mask1:setTouchEnabled(true)
    self.mask2:setTouchEnabled(true)
    self.sub:hide()
    self.add:hide()
  end
end

function ChengLayer:changeValue(dir)
  local value = self:getValue() + dir
  self:valueToRotate(value)
end

function ChengLayer:valueToRotate(value)
  if value < 50 then
    value = 50
  end
  if 999 < value then
    value = 999
  end
  local oldRotate = self.hander:getRotation()
  local newRotate = -(1000 - value) * 0.18
  if self.jump and newRotate < -0.18 and -171 < newRotate then
    local temp = newRotate - oldRotate
    if 0.9 <= temp then
      local times = math.floor(temp / 0.9)
      for i = 1, times do
        self.hander:setRotation(oldRotate + 0.9 * i)
        self:setString(self.tempValue + 5)
      end
    elseif temp <= -0.9 then
      local times = math.floor(temp / -0.9)
      for i = 1, times do
        self.hander:setRotation(oldRotate - 0.9 * i)
        self:setString(self.tempValue - 5)
      end
    end
  else
    self.hander:setRotation(newRotate)
    self:setString(value)
  end
end

function ChengLayer:setString(value)
  self.tempValue = value
  self.value:setString(value)
  self.num:setString(value)
end

function ChengLayer:onTouchBegan(sender)
  self.jump = true
  self:calculateRotate(sender:getBeginPos())
  return true
end

function ChengLayer:onTouchMoved(sender)
  self:calculateRotate(sender:getMovePos())
end

function ChengLayer:onTouchEnded(sender)
  self:calculateRotate(sender:getEndPos())
  self.jump = false
end

function ChengLayer:onTouchCancelled(sender)
  self:calculateRotate(sender:getEndPos())
  self.jump = false
end

function ChengLayer:calculateRotate(pos)
  local tanValue = (pos.y - self.originPos.y) / (pos.x - self.originPos.x)
  local rotate = -math.deg(math.atan(tanValue))
  if pos.x - self.originPos.x < 0 then
    rotate = rotate - 180
  end
  if 0 < rotate then
    rotate = 0
  end
  if rotate < -180 then
    rotate = -180
  end
  local value = 1000 - math.ceil(math.abs(rotate) * 1000 / 180)
  self:valueToRotate(value)
  if game.role.majorGuideStep == 14 and not self.guideHandler then
    self.guideHandler = scheduler.performWithDelayGlobal(function()
      self.mask1:hide()
      self.mask2:hide()
      self.sub:show()
      self.add:show()
      NewGuideLayer.new({step = 14})
    end, 1.2)
  end
end

function ChengLayer:runTrayAnimation()
  self.tray:runAction(cc.MoveBy:create(0.2, cc.p(0, -2)))
end

function ChengLayer:getTray()
  return self.tray
end

function ChengLayer:getValue()
  return tonumber(self.value:getString())
end

function ChengLayer:close()
  self:removeFromParent()
end

return ChengLayer
