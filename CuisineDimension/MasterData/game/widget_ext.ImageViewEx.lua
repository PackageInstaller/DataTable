local WidgetEx = require("widget_ext.WidgetEx")
local ImageViewEx = clone(WidgetEx)

function ImageViewEx:setImage(file)
  self:loadTexture(file)
  return self
end

return ImageViewEx
