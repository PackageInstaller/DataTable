local WidgetEx = require("widget_ext.WidgetEx")
local TextEx = clone(WidgetEx)

function TextEx:setKey(key, ...)
  local string = textByKey(key, ...)
  self:setString(string)
end

function TextEx:setCallback(callback)
  local function func(sender, type)
    if type == ccui.TouchEventType.ended and callback then
      callback(sender)
    end
  end
  
  self:addTouchEventListener(func)
  self.callback = callback
end

return TextEx
