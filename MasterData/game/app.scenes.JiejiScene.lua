local JiejiScene = class("JiejiScene", function()
  return display.newScene("JiejiScene")
end)

function JiejiScene:ctor(params)
  self.params = params or {}
end

function JiejiScene:onEnter()
  EdgeMaskLayer.new(self)
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  if self.params.type == "101" then
    local layer = game:createView("jieji.JiejiMainLayer2", self.params)
  else
    local layer = game:createView("jieji.JiejiMainLayer", self.params)
  end
  BackManager:push(function()
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function JiejiScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return JiejiScene
