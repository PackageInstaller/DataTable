local ActCarbonScene = class("ActCarbonScene", function()
  return display.newScene("ActCarbonScene")
end)

function ActCarbonScene:ctor(params)
  self.params = params or {}
end

function ActCarbonScene:onEnter()
  EdgeMaskLayer.new(self)
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("act_carbon.ActCarbonMainLayer", self.params)
  BackManager:push(function()
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function ActCarbonScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return ActCarbonScene
