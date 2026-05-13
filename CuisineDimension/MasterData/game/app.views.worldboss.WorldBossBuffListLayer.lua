local WorldBossBuffListLayer = class("WorldBossBuffListLayer", UIBase)
local uiData = {
  csbFile = "ui/worldboss/WorldBossBuffListLayer.csb",
  widgets = {
    center = "center",
    mask = "mask",
    textList = "textList"
  }
}

function WorldBossBuffListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function WorldBossBuffListLayer:init(params)
  self.size = params.size or 26
  self.color = params.color or UIHelper.hex2rgb("#FFFFFF")
  self.contentText = params.contentText
  self.textList:setClippingEnabled(true)
  local contentCell = MRichText.new({
    text = self.contentText,
    color = params.color or self.color,
    size = params.size or self.size,
    maxWidth = 800
  })
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(contentCell:getContentSize())
  viewNode:addTo(self.textList)
  contentCell:anch(0.5, 0.5):center(viewNode):addTo(viewNode)
  self.mask:setCallback(function(sender)
    self:close()
  end)
end

return WorldBossBuffListLayer
