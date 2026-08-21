local cc4fGREEN = cc.c4f(0, 1, 0, 1)
local cc4fTRANSPARENT = cc.c4f(0, 0, 0, 0)
local MRookieGuide = class("MRookieGuide", function(params)
  return display.newLayer()
end)

function MRookieGuide:ctor(params)
  self.m_stencil = cc.DrawNode:create()
  self.m_stencil:setPosition(cc.p(0, 0))
  self.m_clipper = cc.ClippingNode:create()
  self.m_clipper:setPosition(cc.p(0, 0))
  self.m_clipper:setStencil(self.m_stencil)
  self.m_clipper:setInverted(true)
  self:addChild(self.m_clipper)
  self.m_content = cc.LayerColor:create(params.bgColor)
  self.m_clipper:addChild(self.m_content)
  self:setTouchEnabled(true)
  local eventDispatcher = self:getEventDispatcher()
  local listenner = cc.EventListenerTouchOneByOne:create()
  listenner:setSwallowTouches(true)
  listenner:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
  listenner:registerScriptHandler(handler(self, self.onTouchMove), cc.Handler.EVENT_TOUCH_MOVED)
  listenner:registerScriptHandler(handler(self, self.onTouchEnd), cc.Handler.EVENT_TOUCH_ENDED)
  eventDispatcher:addEventListenerWithSceneGraphPriority(listenner, self)
  self.regions = {}
end

function MRookieGuide:addRegion(rect, func, removeOnTouch, pattern, size)
  local region = {
    rect = rect,
    func = func,
    removeOnTouch = removeOnTouch
  }
  table.insert(self.regions, region)
  if pattern == "circle" then
    local fRadius = 400
    local nCount = 120
    local coef = 2 * math.pi / nCount
    local circle = {}
    for i = 1, nCount do
      local point = cc.p(0, 0)
      table.insert(circle, point)
    end
    for i = 1, nCount do
      local rads = i * coef
      circle[i].x = fRadius * math.cos(rads)
      circle[i].y = fRadius * math.sin(rads)
    end
    self.m_stencil:drawPolygon(circle)
  else
    local rectangle = {}
    rectangle[1] = cc.p(-rect.width / 2 - size.width / 2, -rect.height / 2 - size.height / 2)
    rectangle[2] = cc.p(rect.width / 2 + size.width / 2, -rect.height / 2 - size.height / 2)
    rectangle[3] = cc.p(rect.width / 2 + size.width / 2, rect.height / 2 + size.height / 2)
    rectangle[4] = cc.p(-rect.width / 2 - size.width / 2, rect.height / 2 + size.height / 2)
    for _, point in ipairs(rectangle) do
      point.x = point.x * 4
      point.y = point.y * 4
    end
    self.m_stencil:drawPolygon(rectangle)
  end
  self.m_stencil:runAction(cc.ScaleTo:create(0.4, 0.25))
  self.m_stencil:setPosition(cc.p(rect.width / 2 + rect.x, rect.height / 2 + rect.y))
end

function MRookieGuide:addRegionWithNode(node, func, removeOnTouch)
  local b = cc.rect(0, 0, node:getContentSize().width, node:getContentSize().height)
  local t = node:getNodeToWorldAffineTransform()
  b = self:RectApplyAffineTransform(b, t)
  self:addRegion(b, func, removeOnTouch, "circle")
end

function MRookieGuide:addRegionWithRect(node, func, removeOnTouch, size)
  local b = cc.rect(0, 0, node:getContentSize().width, node:getContentSize().height)
  local t = node:getNodeToWorldAffineTransform()
  b = self:RectApplyAffineTransform(b, t)
  self:addRegion(b, func, removeOnTouch, "rectangle", size)
end

function MRookieGuide:setBgColor(color4)
  self.m_content:setColor(cc.c3b(color4.r, color4.g, color4.b))
  self.m_content:setOpacity(color4.a)
end

function MRookieGuide:onTouchBegan(touch, event)
  local location = touch:getLocation()
  self.clickedRegin = nil
  for _, region in pairs(self.regions) do
    if cc.rectContainsPoint(region.rect, location) then
      if region.func then
        self.clickedRegin = region
      end
      if self.clickedRegin then
        self.clickedRegin.func(event)
        if self.clickedRegin.removeOnTouch then
          self:removeFromParent(true)
        end
      end
    end
  end
  return true
end

function MRookieGuide:onTouchMove(touch, event)
end

function MRookieGuide:onTouchEnd(touch, event)
  if self.clickedRegin then
    self.clickedRegin.func(event)
    if self.clickedRegin.removeOnTouch then
      self:removeFromParent(true)
    end
  end
end

function MRookieGuide:RectApplyAffineTransform(rect, t)
  local top = rect.y
  local left = rect.x
  local right = rect.x + rect.width
  local bottom = rect.y + rect.height
  
  local function transformPoint(t, p)
    local x = t.a * p.x + t.c * p.y + t.tx
    local y = t.d * p.y + t.b * p.x + t.ty
    return cc.p(x, y)
  end
  
  local topLeft = transformPoint(t, cc.p(left, top))
  local topRight = transformPoint(t, cc.p(right, top))
  local bottomLeft = transformPoint(t, cc.p(left, bottom))
  local bottomRight = transformPoint(t, cc.p(right, bottom))
  local minX = math.min(math.min(topLeft.x, topRight.x), math.min(bottomLeft.x, bottomRight.x))
  local maxX = math.max(math.max(topLeft.x, topRight.x), math.max(bottomLeft.x, bottomRight.x))
  local minY = math.min(math.min(topLeft.y, topRight.y), math.min(bottomLeft.y, bottomRight.y))
  local maxY = math.max(math.max(topLeft.y, topRight.y), math.max(bottomLeft.y, bottomRight.y))
  return cc.rect(minX, minY, maxX - minX, maxY - minY)
end

return MRookieGuide
