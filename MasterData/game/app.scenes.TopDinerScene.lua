local TopDinerScene = class("TopDinerScene", function()
  return display.newScene("TopDinerScene")
end)

function TopDinerScene:ctor(params)
  self.params = params or {}
end

function TopDinerScene:onEnter()
  EdgeMaskLayer.new(self)
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("topDiner.TopDinerMainLayer", self.params)
  BackManager:push(function()
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function TopDinerScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return TopDinerScene
