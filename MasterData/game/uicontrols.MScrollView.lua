local MScrollView = class("MScrollView", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function MScrollView:ctor(params)
  params = params or {}
  self.contentSize = params.size or cc.size(display.width, display.height)
  self.interval = params.interval or 40
  self.offsetPos = params.offsetPos or cc.p(0, self.contentSize.height / 2)
  self.clipping = params.clipping == nil and true or params.clipping
  self._doLayoutDirty = false
  self.cells = {}
  self.cellIndex = 1
  self.innerSize = self.contentSize
  self:size(self.contentSize)
  self:enableNodeEvents()
  self:setTouchEnabled(true)
  self:setClippingEnabled(self.clipping)
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
  self._innerLayer = UIHelper.extend(ccui.Layout:create())
  self._innerLayer:size(self.innerSize)
  self._innerLayer:anch(0, 0):pos(self:getContentSize().width / 2, 0):addTo(self)
end

function MScrollView:addCell(cell)
  cell:addTo(self._innerLayer)
  table.insert(self.cells, cell)
  self._doLayoutDirty = true
end

function MScrollView:onEnter()
  self:doLayOut()
end

function MScrollView:doLayOut()
  if not self._doLayoutDirty then
    return
  end
  local xPos = self.offsetPos.x
  local yPos = self.offsetPos.y
  local width = 0
  for index, cell in ipairs(self.cells) do
    cell:pos(xPos, yPos)
    xPos = xPos + cell:getContentSize().width + self.interval
    width = width + cell:getContentSize().width
  end
  if #self.cells > 1 then
    width = width + self.interval * (#self.cells - 1)
  end
  self.innerSize = cc.size(width, self._innerLayer.height)
  self._innerLayer:size(self.innerSize)
  self._doLayoutDirty = false
  self:doScale()
end

function MScrollView:removeAllChildren()
  self.cells = {}
  self._innerLayer:removeAllChildren()
end

function MScrollView:onTouchBegan(sender)
  local location = self:getBeginPos()
  self.drag = {
    beganTime = os.clock(),
    beginX = location.x,
    lastX = location.x,
    mapX = self._innerLayer:getPositionX()
  }
  return true
end

function MScrollView:onTouchMoved(sender)
  local location = self:getMovePos()
  if math.abs(location.x - self.drag.lastX) < 1 then
    return
  end
  self.drag.lastX = location.x
  self:moveOffset(location.x - self.drag.beginX)
end

function MScrollView:onTouchEnded(sender)
  local location = self:getEndPos()
  local elapse = os.clock() - self.drag.beganTime
  local speed = (location.x - self.drag.beginX) / 150 / elapse
  if math.abs(speed) >= 20 then
    self.drag = {
      mapX = self._innerLayer:getPositionX()
    }
    self:moveOffset(speed * 10, true)
  end
end

function MScrollView:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function MScrollView:moveOffset(offset, animation)
  local center = self.contentSize.width / 2
  
  local function normalOffset(_offset)
    local pos = self.drag.mapX + _offset
    if pos > center then
      pos = center
    elseif pos < center - self.innerSize.width then
      pos = center - self.innerSize.width
    end
    return pos, pos - self.drag.mapX
  end
  
  local targetX, targetOffset = normalOffset(offset)
  if animation then
    self._innerLayer:stopAllActions()
    if self.handler then
      scheduler.unscheduleGlobal(self.handler)
    end
    local action = self._innerLayer:runAction(transition.sequence({
      cc.EaseExponentialOut:create(cc.MoveBy:create(1, cc.p(targetOffset, 0))),
      cc.CallFunc:create(function()
        if self.handler then
          scheduler.unscheduleGlobal(self.handler)
        end
      end)
    }))
    self.handler = scheduler.scheduleUpdateGlobal(function()
      self:doScale()
    end, 0.03333333333333333)
  else
    self._innerLayer:pos(targetX, 0)
  end
  self:doScale()
end

local z = display.width / 2 * (display.width / 2) * 4

function MScrollView:doScale()
  local center = self.contentSize.width / 2 - self._innerLayer:getPositionX()
  for _, cell in ipairs(self.cells) do
    local x = math.abs(center - cell:getPositionX())
    if self.clipping and x > self.contentSize.width / 2 + cell:getContentSize().width then
    else
      if x > display.width / 2 then
        x = display.width / 2
      end
      cell:scale(1 - x * x / z)
    end
  end
end

function MScrollView:onExit()
  if self.handler then
    scheduler.unscheduleGlobal(self.handler)
    self.handler = nil
  end
end

return MScrollView
