local MoonScene = class("MoonScene", function()
  return display.newScene("MoonScene")
end)

function MoonScene:ctor(params)
  self.params = params
end

function MoonScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("carbon_s.MoonBattleLayer", {
    carbonId = self.params.carbonId
  })
  BackManager:push(function()
    game:enterScene("MidAutumnScene", {sceneType = "general1"})
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function MoonScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return MoonScene
