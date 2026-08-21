local RouGeScene = class("RouGeScene", function()
  return display.newScene("RouGeScene")
end)

function RouGeScene:ctor(params)
  self.params = params or {}
end

function RouGeScene:onEnter()
  EdgeMaskLayer.new(self)
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("rouge.RouGeMainLayer", self.params)
  BackManager:push(function()
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function RouGeScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return RouGeScene
