local WidgetEx = {}

function WidgetEx:setCallback(callback)
  local function func(sender, type)
    if type == ccui.TouchEventType.ended and callback then
      callback(sender)
    end
  end
  
  self:setTouchEnabled(true)
  self:addTouchEventListener(func)
  self.callback = callback
end

function WidgetEx:setCallbackTotal(callback1, callback2, callback3, callback4)
  local function func(sender, type)
    if type == ccui.TouchEventType.began then
      if callback1 then
        callback1(sender)
      end
    elseif type == ccui.TouchEventType.moved then
      if callback2 then
        callback2(sender)
      end
    elseif type == ccui.TouchEventType.ended then
      if callback3 then
        callback3(sender)
      end
    elseif type == ccui.TouchEventType.canceled and callback4 then
      callback4(sender)
    end
  end
  
  self:setTouchEnabled(true)
  self:addTouchEventListener(func)
  self.callback = callback3
end

function WidgetEx:getBeginPos()
  local pos = self:getTouchBeganPosition()
  local pt = self:convertToNodeSpace(pos)
  return pt
end

function WidgetEx:getMovePos()
  local pos = self:getTouchMovePosition()
  local pt = self:convertToNodeSpace(pos)
  return pt
end

function WidgetEx:getEndPos()
  local pos = self:getTouchEndPosition()
  local pt = self:convertToNodeSpace(pos)
  return pt
end

return WidgetEx
